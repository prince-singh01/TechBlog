package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    //fetch all category from database
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    
    
       //It will get all the categories from database
    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList<>();

        try {

//            Getting all information from database categories to a list
            String q = "select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(q);

            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");

//                Initializing the values of constrtuctor of class Post by giving data from database
                Category c = new Category(cid, name, description);
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean savePost(Post p) {
        boolean flag = false;

        try {
            //getting the data from servlet and sending it to database
            String q = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);

            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());

            pstmt.executeUpdate();
            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    
    //get all the post from databases
    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();

        //fetch all the posts .....
        
        try {
            
            String q="select * from posts order by pid desc";
            PreparedStatement p=con.prepareStatement(q);
            
            ResultSet rs=p.executeQuery();
            
            while(rs.next()){
                
                int pid=rs.getInt("pid");
                String pTitle=rs.getString("pTitle");
                String pContent=rs.getString("pContent");
                String pCode=rs.getString("pCode");
                String pPic=rs.getString("pPic");
                Timestamp date=rs.getTimestamp("pDate");
                int catId=rs.getInt("catId");
                int userId=rs.getInt("userId");
                
                Post post=new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                
                list.add(post);
                        
                
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public List<Post> getPostByCatId(int catId){
         List<Post> list = new ArrayList<>();

         //get  all the post of specific id
         
         try {
            
            String q="select * from posts where catId=?";           
            
            PreparedStatement p=con.prepareStatement(q);
            p.setInt(1, catId);
            
            ResultSet rs=p.executeQuery();
            
            while(rs.next()){
                
                int pid=rs.getInt("pid");
                String pTitle=rs.getString("pTitle");
                String pContent=rs.getString("pContent");
                String pCode=rs.getString("pCode");
                String pPic=rs.getString("pPic");
                Timestamp date=rs.getTimestamp("pDate");               
                int userId=rs.getInt("userId");
                
                Post post=new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                
                list.add(post);
                        
                
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Post getPostByPostId(int postId){
        
        Post po=null;
                
        String q="select * from posts where pid=? ";
       
        try{
            
        PreparedStatement p=this.con.prepareStatement(q);        
        p.setInt(1, postId);
        
        ResultSet rs=p.executeQuery();
        
        if(rs.next()){
                int pid=rs.getInt("pid");
                String pTitle=rs.getString("pTitle");
                String pContent=rs.getString("pContent");
                String pCode=rs.getString("pCode");
                String pPic=rs.getString("pPic");
                Timestamp date=rs.getTimestamp("pDate");               
                int userId=rs.getInt("userId");
                int catId=rs.getInt("catId");
                
                po=new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
        }
        
        }catch(Exception e){
            e.printStackTrace();
        }
        return po;
    }
    
}
