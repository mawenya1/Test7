<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>注册页面</title>
<link href="styles/index.css" rel="stylesheet">
</head>
<body>
<!-- 文件引入的两种方式 -->
<%--  <%@include file="include/header.inc.html"%> --%>
<jsp:include page="include/header.inc.html"></jsp:include>
<p class="welcome">欢迎进入购物车注册界面</p>
<form action="doreg.jsp" method="post">
<div>
<h2>用户名：</h2><input class="input" type="text" name="username"  placeholder="请输入用户名">
</div>
<div>
<h2>密 码：</h2><input class="input" type="password" name="pwd"  placeholder="请输入您的密码">
</div>
<div>
<input class="input1" type="submit" value="注册"> 
<input class="input1" type="reset" value="重置">
</div>
<h3>已有账号，直接<a href="index.jsp">登陆</a></h3>
</form>
<%@include file="include/footer.inc.html"%>
</body>
</html>


<%@page import="java.sql.*"%>
<%@ page language="java" pageEncoding="GB18030"%>

<%
try{
Class.forName("com.mysql.jdbc.Driver");//加载数据库驱动，注册到驱动管理器
String url = "jdbc:mysql://127.0.0.1:3301/shopcar";//数据库连接字符串
String usename = "root";
String password = "123456";
Connection conn = DriverManager.getConnection(url,usename,password);//创建Connection连接
if(conn != null){
System.out.println("数据库链接成功！");
//conn.close();//关闭数据库连接
String insert_db = "INSERT INTO `user`(uesrname,password)values(?,?)";
//插入操作
PreparedStatement statement = (PreparedStatement)conn.prepareStatement(insert_db);

statement.setString(1,request.getParameter("username"));
statement.setString(2,request.getParameter("pwd"));
statement.executeUpdate();

session.setAttribute("userName", request.getParameter("username"));//给当前注册用户开启会话
out.println("插入成功");
out.println("页面在3秒钟内自动跳转");
out.println("<a href=\"goods.jsp\">点击请进入购物页面</a>");
}else{
out.println("数据库连接失败");//输出错误信息
}
}catch(ClassNotFoundException e){
e.printStackTrace();
}catch(SQLException e){
e.printStackTrace();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="refresh" content="2;url=goods.jsp"> 
<title>注册页面</title>
</head>
<body>

</body>
</html>



<%@ page language="java" import="java.util.*"
contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
Cookie[] cookies = request.getCookies();
String uname = "";
String upwd = "";
String utrue = "";
if(cookies != null ){
for(int i = 0 ; i < cookies.length; i++){
Cookie cookie = cookies[i];
if(cookie.getName().equals("rname")){
uname = cookie.getValue();
}else if(cookie.getName().equals("rpwd")){
upwd = cookie.getValue();
}else if(cookie.getName().equals("rtrue")){
utrue = cookie.getValue();
}
}
}
%>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>欢迎进入购物车</title>
<link href="styles/index.css" rel="stylesheet">
</head>
<body>
<%-- <%@include file="include/header.inc.html"%> --%>
<jsp:include page="include/header.inc.html"></jsp:include>
<p class="welcome">欢迎进入购物车登陆界面</p>
<form action="show.jsp">
<div>
<h2>用户名：</h2><input class="input" type="text" name="username" value="<%= uname %>" placeholder="请输入用户名">
</div>
<div>
<h2>密 码：</h2><input class="input" type="password" name="pwd" value="<%= upwd %>" placeholder="请输入您的密码">
</div>
<div>
<input type="checkbox" name="remember" value="true"> <input class="input1"
type="submit" value="登陆"> <input class="input1" type="reset" value="重置">
</div>
<div><p>还没有注册，请先注册</p>  
<a href="reg.jsp">注册</a>
</div>
</form>
<%@include file="include/footer.inc.html"%>
</body>
</html>



<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>
<%

String username = request.getParameter("username");
String password = request.getParameter("pwd");
String remember = request.getParameter("remember");

if(username == null)
username="";
if(password == null)
password="";
if(remember == null)
remember = "false";

String driver = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://127.0.0.1:3301/shopcar";
String user = "root";
String password_db = "123456";
try {
Class.forName(driver);//加载驱动
Connection conn = DriverManager.getConnection(url,user,password_db);
// 连接URL为 jdbc:mysql://服务器地址/数据库名 ，后面的2个参数分别是登陆用户名和密码        
System.out.println("Success connect Mysql server!");
// statement用来执行SQL语句
Statement stmt = conn.createStatement();
// 结果集
ResultSet rs = stmt.executeQuery("select * from `user`");
// student 为你表的名称
while (rs.next()) {
String name = rs.getString("uesrname");
String pwd = rs.getString("password");
/* out.println(rs.getString("uesrname"));
out.println(rs.getString("password")+"<br>"); */
if(username!=null && username.equals(name) && password.equals(pwd))
{
if(remember != null && remember.equals("true"))
{
Cookie cookie1 = new Cookie("rname",username);
Cookie cookie2 = new Cookie("rpwd",password);
cookie1.setMaxAge(60*60*24*7);
cookie2.setMaxAge(60*60*24*7);
response.addCookie(cookie1);
response.addCookie(cookie2);
}
session.setAttribute("userName",username);
response.sendRedirect("goods.jsp");
}else{
/* response.sendRedirect("index.jsp"); */
out.println("查询不成功");
/* out.println("<a href = \"index.jsp\">请重新登陆</a>"); */
}

}
} catch (Exception e) {
// TODO: handle exception
System.out.print("get data error!");
e.printStackTrace();
}





%>
</body>
</html>



<%@page import="java.sql.*"%>
<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>购物页面</title>
<style>
td{border:1px solid green;}
</style>
</head>
<body>
<!--创建数据表 create table `goods` (id int not null auto_increment primary key,goods_name varchar(20), goodspic varchar(30),goods_pri varchar(20), goods_name_en varchar(20)); -->
<p>欢迎用户:
<%= 
session.getAttribute("userName")
%>
</p>
<p>请选购商品并填写所需要购买的数量</p>
<form action="order2.jsp" method="post">
<table style="border:1px solid green;">
<thead>
<tr>
<th>编号</th>
<th>商品名</th>
<th>单价</th>
<th>购买数量</th>
</tr>
</thead>
<tbody>

<%
try{
Class.forName("com.mysql.jdbc.Driver");//加载数据库驱动，注册到驱动管理器
String url = "jdbc:mysql://127.0.0.1:3301/shopcar";//数据库连接字符串
String usename = "root";
String password = "123456";
Connection conn = DriverManager.getConnection(url,usename,password);//创建Connection连接
// statement用来执行SQL语句
Statement stmt = conn.createStatement();
// 结果集
ResultSet rs = stmt.executeQuery("select * from `goods1`");
// student 为你表的名称
while (rs.next()) {
application.setAttribute("id", rs.getString("id"));
application.setAttribute("goods_name", rs.getString("goods_name"));
application.setAttribute("goodspic", rs.getString("goodspic"));
application.setAttribute("goods_pri", rs.getString("goods_pri"));
application.setAttribute("goods_name_en", rs.getString("goods_name_en"));
/* String id = (rs.getString("id"));
String goods_name = (rs.getString("goods_name"));
String goodspic = (rs.getString("goodspic"));
String goods_pri = (rs.getString("goods_pri"));
String goods_name_en = (rs.getString("goods_name_en")); */
%>
<tr>
<td><%=application.getAttribute("id") %></td>
<td><img src="<%=application.getAttribute("goodspic") %>"><%=application.getAttribute("goods_name") %></td>
<td>￥<%=application.getAttribute("goods_pri") %></td>
<td><input type="text" name="<%=application.getAttribute("goods_name_en") %>" id="" value="" placeholder="0"></td>
</tr>
<%

}

}catch(ClassNotFoundException e){
e.printStackTrace();
}catch(SQLException e){
e.printStackTrace();
}
%>

</tbody>
</table>
<input type="submit" value="提交订单">
</form>
</body>
</html>


<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="GB18030"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>购物页面</title>
<style>
td{border:1px solid green;}
</style>
</head>
<body>
<!--创建数据表 create table `goods` (id int not null auto_increament primary key,goods_name varchar(20), goodspic varchar(30),goods_name_en varchar(20)); -->
<p>欢迎用户:
<%= 
session.getAttribute("userName")
%>
</p>
<p>请选购商品并填写所需要购买的数量</p>
<form action="order.jsp" method="post">
<table style="border:1px solid green;">
<thead>
<tr>
<th>编号</th>
<th>商品名</th>
<th>单价</th>
<th>购买数量</th>
</tr>
</thead>
<tbody>
<tr>
<td>1</td>
<td><img src="./images/apple.jpg"/>苹果</td>
<td>￥5.0</td>
<td><input type="text" name="apple" id="" placeholder="0"></td>
</tr>
<tr>
<td>2</td>
<td><img src="./images/orange.jpg"/>橘子</td>
<td>￥3.0</td>
<td><input type="text" name="orange" id="" placeholder="0"></td>
</tr>
<tr>
<td>3</td>
<td><img src="./images/banana.jpg"/>香蕉</td>
<td>￥2.0</td>
<td><input type="text" name="banana" id="" placeholder="0"></td>
</tr>
<tr>
<td>4</td>
<td><img src="./images/youzi.jpg"/>柚子</td>
<td>￥4.5</td>
<td><input type="text" name="grapefruit" id="" placeholder="0"></td>
</tr>
<tr>
<td>5</td>
<td><img src="./images/peach.jpg"/>桃子</td>
<td>￥5.5</td>
<td><input type="text" name="peach" id="" placeholder="0"></td>
</tr>
</tbody>
</table>
<input type="submit" value="提交订单">
<!-- <button type="submit">提交订单</button> -->
</form>
</body>
</html>

