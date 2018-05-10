package 迷你图书管理系统;

import java.util.Scanner;

public class BookMgr {

    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        //数据初始化6本图书
        //图书：图书的姓名，图书借阅状态，图书借阅日期，图书借阅次数
        String[]names = new String[6];
        int []states = new int[6];//0可借，1已借出
        int []dates = new int[6];
        int [] counts = new int[6];
        
        names[0] = "白雪公主";
        dates[0] = 5;
        states[0] = 1;
        counts[0] = 10;
        names[1] = "葫芦兄弟";
        dates[1] = 0;
        states[1] = 0;
        counts[1] = 16;
        names[2] = "白雪公主2";
        dates[2] = 0;
        states[2] = 0;
        counts[2] = 78;
        //用户是否退出系统 true代表不退出，false代表退出系统。
        boolean flag = true;
        int num = 0;
        do{
            System.out.println("********欢迎使用迷你图书管理系统********");
            System.out.println("1.查看图书");
            System.out.println("2.新增图书");
            System.out.println("3.借阅图书");
            System.out.println("4.归还图书");
            System.out.println("5.删除图书");
            System.out.println("6.退出系统");
            System.out.print("请选择你的操作：");
            
            int choose = input.nextInt();
            switch(choose){
            case 1:
                //查看图书
                System.out.println("\n图书信息列表-->");
                System.out.println("图书序号\t图书名称\t图书状态\t借阅日期\t借阅次数");
                //循环遍历所有的图书
                for (int i = 0;i<names.length;i++) {
                    if (names[i] != null) {
                        String state = (states[i] == 0)?"可借阅":"已借出";
                        String date = (dates[i] == 0)?"":dates[i]+"日";
                        String count = counts[i]+"次";
                        System.out.println((i+1)+"\t"+names[i]+"\t"+state+"\t"+date+"\t"+count);
                    }else{
                        //遇到第一个为null的图书的名称，意味着后面的图书也为null不必循环了
                        break;
                    }
                }
                break;
            case 2:
                //新增图书
                System.out.println("\n图书信息列表-->");
                System.out.print("请输入新增图书名称：");
                String name = input.next();
                //是否能新增图书，如果货架满了（6）则无法添加false能添加true
                
                boolean flagAdd = false;
                for (int i = 0;i<names.length;i++) {
                    if (names[i] == null) {
                        flagAdd = true;
                        names[i] = name;
                        System.out.println("图书《"+name+"》添加成功！");
                        break;
                    }
                }
                if (!flagAdd) {
                    System.out.println("对不起，货架已满，无法添加图书！");
                }
                break;
            case 3:
                //借阅图书
                break;
            case 4:
                //归还图书
                break;
            case 5:
                //删除图书
                break;
            case 6:
                //退出系统
                flag = false;
                break;
            default:
                //输入错误的数字
                flag = false;
                break;
            }
            //如果flag== false则结束循环，跳出系统
            if (flag == false) {
                //跳出循环
                break;
            }else{
                //用户不结束使用系统，代表用户想返回主菜单继续操作
                System.out.println("请输入0返回");
                num= input.nextInt();
            }
        }while(num == 0);
        System.out.println("谢谢，欢迎使用！");
        