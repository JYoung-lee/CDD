package cdd.aop.advice;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cdd.service.bean.UserService;

@Aspect
public class CddAspect {
	@Autowired
	private UserService userService = null;
	
	@Around("within(cdd.controller.bean.MainController) || within(cdd.controller.bean.MyPageController) || within(cdd.controller.bean.FeedsController)")
	public  Object sessionCheck(ProceedingJoinPoint j)throws Throwable{
		// before
		HttpSession session = (((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest()).getSession();
		String sessId = (String)session.getAttribute("memId");
		if(sessId == null) {
			return "redirect:/user/loginForm.cdd";
		}else {
			// 회원 차단 여부
			int bCh = userService.blockCh(sessId);
			if(bCh == 1) {
				session.removeAttribute("memId");
				return "redirect:/user/loginForm.cdd";
			}
		}
		Object obj = j.proceed();
		// after
		
		
		return obj;
	}
	
	@Around("within(cdd.controller.bean.AdminController)")
	public Object adminCheck(ProceedingJoinPoint j)throws Throwable{
		//before
		HttpSession session = (((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest()).getSession();
		String sessId = (String)session.getAttribute("memId");
		if(sessId == null) {
			return "redirect:/user/loginForm.cdd";
		}else {
			if(!"admin".equals(sessId)) {
				return "redirect:/main.cdd";
			}else {
				return j.proceed();
			}
		}
	}
}
