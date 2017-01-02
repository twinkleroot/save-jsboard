package kr.sir.controller.install;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.sir.config.DataConfig;
import kr.sir.domain.module.AgreeForm;
import kr.sir.domain.module.ConfigForm;
import kr.sir.service.install.InstallService;

@Controller
@RequestMapping(value = "/install")
public class InstallController {
	
	private InstallService installService;
	
	private DataConfig dataConfig;
	
	@Autowired
	public void setInstallService(InstallService installService) {
		this.installService = installService;
	}

	@Autowired
	public void setDataConfig(DataConfig dataConfig) {
		this.dataConfig = dataConfig;
	}

	// 최초 설치 페이지로 이동
	@RequestMapping(value = {"", "/step","/step/1"})
	public String install() {
		return "/install/step1_info";
	}
	
	// licence 동의 페이지로 이동
	@RequestMapping(value = "/step/2")
	public String licence() {
		return "/install/step2_licence";
	}
	
	// 설정 정보 입력 페이지로 이동
	@RequestMapping(value = "/step/3")
	public String writeConfigForm(Model model, AgreeForm agreeForm) {
		model.addAttribute("isAgree", agreeForm.getAgree());
		return "/install/step3_form";
	}
	
	// 설정 결과 페이지로 이동
	@RequestMapping(value = "/step/4")
	public String result(Model model, ConfigForm configForm) {
		// 1. schema로 db 생성
		
		// 2. application.yml에 table_prefix 등록
		
		// 3. member table에 관리자 정보 insert
		
		// 4. config table에 설정 정보 insert
		System.out.println(configForm.toString());
		installService.writeConfigInfo(dataConfig.getPrefix(), configForm);
		
		return "/install/step4_result";
	}
}
