package ga.bowwow.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ga.bowwow.service.board.Board;
import ga.bowwow.service.board.BoardService;

@Controller
public class TilesController {
	@RequestMapping("/tiles/{path}.do")
	public ModelAndView tiles(@PathVariable("path") String path) {
		System.out.println(">> tiles 객체 생성!"
				+ path);
		ModelAndView mav = new ModelAndView();
		System.out.println("path : " + path);
		mav.setViewName("/" + path);


		return mav;
	}

}
