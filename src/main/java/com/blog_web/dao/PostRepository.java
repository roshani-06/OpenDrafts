package com.blog_web.dao;

import com.blog_web.bean.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PostRepository extends JpaRepository<Post, Long>{
	List<Post> findAllByOrderByCreatedAtDesc();
	

}
