package cn.qdas.core.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import cn.qdas.core.bean.User;

public class LoginFilter implements Filter {
	public FilterConfig config;
	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest= (HttpServletRequest) request;
		HttpServletResponseWrapper wrapper = new HttpServletResponseWrapper((HttpServletResponse) response);
		User user= (User) httpRequest.getSession().getAttribute("user");
		String[] loginList=config.getInitParameter("loginStrings").split(";");
		String redirectPath=httpRequest.getContextPath()+config.getInitParameter("redirectPath");
		if(isContains(loginList,httpRequest.getRequestURL().toString())) {
			chain.doFilter(request, response);
			return;
		}
		if(user!=null) {
			System.out.println("filter------------"+user.getUserName());
			chain.doFilter(request, response);
			return;
		}else {
			wrapper.sendRedirect(redirectPath);
			return;
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		config=filterConfig;
	}
	public boolean isContains(String[] regx,String container) {
		boolean result=false;
		for(int i=0;i<regx.length;i++) {
			if(container.indexOf(regx[i]) != -1) {
				return true;
			}
		}
		return result;
	}
}
