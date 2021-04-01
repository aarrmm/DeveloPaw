package ga.bowwow.controller.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ga.bowwow.controller.user.UserCRUDGenericController;
import ga.bowwow.service.user.VO.UserDetail;
import ga.bowwow.service.user.impl.UserDetailServiceImpl;

@Controller
@RequestMapping("/detail")
public class UserDetailController extends UserCRUDGenericController<UserDetail> {
	
	public UserDetailController(@Autowired UserDetailServiceImpl service) {
		System.out.println("---->>> UserDetailController() 객체생성");
		this.service = service;
		setDomainRoute("/ok", "/auth.login");
	}
	
	//TODO memberSerial의 동기화 작업이 필요함!
	@RequestMapping(value="/signupDetail") //CRUD페이지
	public String getDetailInfo(@ModelAttribute("userDetail") UserDetail userDetail) {
		return "/auth.myDetail";
	}
	
	//TODO 컨트롤러가 너무 구체적인 작업을 하고 있음, GENERICCONTROLLER를 사용하지 않고 있음. 파이프라인 정도의 역할만 해아함.
	private String simpleOkPageDistributor(boolean isOK) {
		return (isOK) ? "/ok" : "failedRoute <- usually itself";
	}
}