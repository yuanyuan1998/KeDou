package com.kedou.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kedou.dao.UserDaoImpl;
import com.kedou.entity.Collection;
import com.kedou.entity.History;
import com.kedou.entity.Torder;
import com.kedou.entity.User;
import com.kedou.entity.UserRoleRelation;
import com.kedou.service.common.CommonServiceImpl;
import com.kedou.util.BCrypt;
import com.kedou.util.SendEmailThread;

@Service
@Transactional(readOnly=false)
public class UserServiceImpl {
	@Resource
	private UserDaoImpl userDaoImpl;
	@Resource
	private CommonServiceImpl commonServiceImpl;//公共的方法实现
	
	/**
	 * 
	 * @desc 注册用户
	 * @author yuanyuan
	 * @createDate 2018年3月28日
	 * @return 用户主键
	 * @throws Exception
	 */
	@Transactional
	public int registerUser(User u) throws Exception{
		//向用户输入的邮箱发送验证邮件 并返回激活验证码
		String code = this.sendEmail(u.getUserEmail());
		   //添加激活验证码
			 u.setVerifyNum(code);
		   //设置账户状态为未激活状态
			 u.setState(0);
			 
		//随机生成 salt
		String salt =UUID.randomUUID().toString().replace("-", "");
		//使用 Bcrypt进行二次加密
		String hashedPwd = BCrypt.hashpw(u.getUserPwd()+salt, BCrypt.gensalt());
		   //设置二次加密后的密码
		     u.setUserPwd(hashedPwd);
		   //设置salt值
		     u.setSalt(salt);
		 //获取当地时间  并设置为用户创建时间
		     u.setCreateTime(new Date());
		 //设置用户登录次数为 0
		     u.setLoginCount(0);
		  
		 //创建用户角色联系实体
		  UserRoleRelation urr = new UserRoleRelation();
		     
		
			this.userDaoImpl.save(u);
			  //设置用户角色联系的用户ID
			     urr.setUrrId(u.getUserId());
			  //设置用户角色联系的角色ID
			     urr.setRoleId(1);
			     this.userDaoImpl.saveUserRoleRelation(urr);
			return u.getUserId();
	}
	/**
	 * @desc 发送激活邮件
	 * @author yuanyuan
	 * @createDate 2018年3月28日
	 * @return 用户激活标识码
	 * 
	 */
	public  String  sendEmail(String emailAddress){  
		//生成用户code
        String code=UUID.randomUUID().toString().replace("-", "");
		new SendEmailThread(emailAddress,code).start();  //向用户注册的邮箱发送验证码
		return code;
    }  
	/**
	 * 重新发送激活邮件
	 * @param emailAddress
	 * @param u
	 * @return
	 */
	public int resendEmail(String emailAddress,User u) {
		//向用户输入的邮箱发送验证邮件 并返回激活验证码
				String code = this.sendEmail(u.getUserEmail());
				
				   //添加激活验证码
					 u.setVerifyNum(code);
		//更新数据库邮件激活码字段
			Object [] params = {code,u.getUserId()};
			String hql = "update User as u set u.verifyNum =? where u.userId = ?";
			try {
				this.userDaoImpl.updateByProperty(hql, params);
			} catch (Exception e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
				return -1;
			}
			return u.getUserId();
	}
	/**
	 * 
	 * @desc 通过邮箱或电话查找用户
	 * @author zhangtianrun
	 * @createDate 2018年3月28日
	 * @return User
	 */
	public User findByAcount(String username)throws Exception  {
		
			return this.userDaoImpl.findByUsername(username);
		
	}
	/**
	 * 更新用户信息(用户更改信息)
	 * @param state
	 * @throws Exception 
	 */
	@Transactional
	public void updateUserMessage(String username,String gender,String userDiscription,int id) throws Exception{
		Object params[] = {username,gender,userDiscription,id};
		String hql = "update User as u set u.userName= ? , u.gender=?,u.userDiscription=? where u.userId =?";
		this.userDaoImpl.updateByProperty(hql, params);
	}
	/**
	 * 更改登陆状态
	 * @param state
	 */
	@Transactional(readOnly=false)
	public int changeState(int state,int id) {
		Integer params[] = {state,id};
		String hql = "update User as u set u.state= ? where u.userId =?";
		try {
			userDaoImpl.updateByProperty(hql, params);
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return -1;
		}
		return id;
	}
	/**
	 * 更新用户登录信息 （登陆时间 上次登录时间 登录次数）
	 * @param u
	 * @return 更新成功 返回 用户ID 否则 返回 -1
	 */
	public int updateLoginInfo(User u) throws Exception{
		Object [] params = {u.getLoginTime(),u.getLastLoginTime(),u.getLoginCount(),u.getLastLoginIp(),u.getUserIp(),u.getUserId()};
		for(Object s: params) {
			System.out.println(s.toString());
		}
		String hql = "update User as u set u.loginTime= ? , u.lastLoginTime= ?,u.loginCount= ?,u.lastLoginIp= ?,u.userIp= ? where u.userId=?";
		
			this.userDaoImpl.updateByProperty(hql, params);
		return u.getUserId();
	}
	/**
	 * 通过激活验证码查询用户
	 * @param code
	 * @return
	 */
	public User findByVerifyNum(String code) {
			User u;
		try {
			u=userDaoImpl.findByVerifyNum(code);
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			u=null;
		}
		return u;
	}
	/**
	 * 
	 * @desc 登陆
	 * @author kangziyun
	 * @createDate 2018年3月29日
	 * @param String username
	 * @param String pwd
	 * @return -1 0 1
	 *  如果密码错误     返回 -1  
	 *  如果账号不存在  		返回   0
	 *  如果正确            		返回   User
	 *  如果查询错误    	 	返回 -2
	 *  如果账户未激活 		返回 -3
	 *  如果账户被锁定            返回 -4
	 *  如果账户状态值异常     返回 -5
	 */
	public User login(User us,String pwd) {
			String salt = us.getSalt();
			//判断账户状态是否为 可登陆状态
			if(us.getState()!=1) {
				return us;
			}else {
				if(BCrypt.checkpw(pwd+salt,us.getUserPwd())){
					 //设置登录次数
					     us.setLoginCount(us.getLoginCount()+1);
					 //设置用户上次登录时间
					     us.setLastLoginTime(us.getLoginTime());
					 //设置用户登录时间
					     us.setLoginTime(new Date());
					return us;//可以登陆
				}else{
					return null;//密码错误
				}
			}
	}
	/**
	 * 
	 * @desc 通过用户ID查找用户
	 * @author 陈
	 * @createDate 
	 * @return User
	 */
	public User findByUserId(int userid)throws Exception  {
		
			return this.userDaoImpl.findByUserId(userid);
		
	}
	/**
	 * @desc 通过用户ID查找收藏课程
	 * @author 陈
	 * @createDate 
	 * @return 
	 */
	public List<Collection> findCollectionByUserId(int userid)throws Exception  {
		
			return this.userDaoImpl.findCollectionByUserId(userid);
		
	}
	/**
	 * @desc 通过用户ID查找预约课程
	 * @author 陈
	 * @createDate 
	 * @return 
	 */
	public List<Torder> findYuyueByUserId(int userid)throws Exception  {
		
			return this.userDaoImpl.findYuyueByUserId(userid);
		
	}
	/**
	 * @desc 通过用户ID查找访问历史课程
	 * @author 陈
	 * @createDate 
	 * @return 
	 */
	public List<History> findHistoryByUserId(int userid)throws Exception  {
		
			return this.userDaoImpl.findHistoryByUserId(userid);
		
	}
	/**
	 * @desc 通过用户ID和课程ID删除收藏课程
	 * @author 陈
	 * @createDate 
	 * @return User
	 */
	public void deleteCollectionByCourseId(int courseid,int userid)throws Exception  {
		
			this.userDaoImpl.deleteCollectionByCourseId(courseid,userid);
		
	}
	/**
	 * @desc 通过用户ID和课程ID删除预约课程
	 * @author 陈
	 * @createDate 
	 * @return User
	 */
	public void deleteYuyueByCourseId(int courseid,int userid)throws Exception  {
		
			this.userDaoImpl.deleteYuyueByCourseId(courseid,userid);
		
	}
	/**
	 * @desc 通过用户ID和课程ID删除访问历史课程
	 * @author 陈
	 * @createDate 
	 * @return User
	 */
	public void deleteHistoryByCourseId(int courseid,int userid)throws Exception  {
		
			this.userDaoImpl.deleteHistoryByCourseId(courseid,userid);
		
	}
	/**
	 * @desc 通过用户ID分页查找收藏课程
	 * @author 陈
	 * @createDate 
	 * @return User
	 */
	public List<Collection> findByPage(int pageNum, int pageSize,int userid)throws Exception  {
		
			return this.userDaoImpl.findByPage(pageNum,pageSize,userid);
		
	}
	/**
	 * @desc 通过用户ID查找分页预约课程
	 * @author 陈
	 * @createDate 
	 * @return User
	 */
	public List<Torder> findByPageYuyue(int pageNum, int pageSize,int userid)throws Exception  {
		
			return this.userDaoImpl.findByPageYuyue(pageNum,pageSize,userid);
		
	}
	/**
	 * @desc 通过用户ID查找分页访问历史课程
	 * @author 陈
	 * @createDate 
	 * @return User
	 */
	public List<History> findByPageHistory(int pageNum, int pageSize,int userid)throws Exception  {
		
			return this.userDaoImpl.findByPageHistory(pageNum,pageSize,userid);
		
	}
	/**
	 * 
	 * @desc 根据用户id查询其收藏课程的总数
	 * @author 陈
	 * @createDate 
	 * @return count
	 */
	public long findCollectionCount(int userid)throws Exception{
		return this.userDaoImpl.findCollectCount(userid);
	}
	/**
	 * 
	 * @desc 根据用户id查询其预约课程的总数
	 * @author 陈
	 * @createDate 
	 * @return count
	 */
	public long findYuyueCount(int userid)throws Exception{
		return this.userDaoImpl.findYuyueCount(userid);
	}
	/**
	 * 
	 * @desc 根据用户id查询其访问历史课程的总数
	 * @author 陈
	 * @createDate 
	 * @return count
	 */
	public long findHistoryCount(int userid)throws Exception{
		return this.userDaoImpl.findHistoryCount(userid);
	}
	
}
