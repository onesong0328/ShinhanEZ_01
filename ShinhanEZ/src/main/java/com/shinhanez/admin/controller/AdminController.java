package com.shinhanez.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shinhanez.admin.domain.Customer;
import com.shinhanez.admin.service.CustomerService;
import com.shinhanez.domain.ShezUser;

/**
 * 관리자 컨트롤러
 * - 고객(보험자) CRUD
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private CustomerService customerService;

    private static final int PAGE_SIZE = 10;

    // 관리자 권한 체크
    private boolean isAdmin(HttpSession session) {
        ShezUser user = (ShezUser) session.getAttribute("loginUser");
        return user != null && "ROLE_ADMIN".equals(user.getRole());
    }

    // 관리자 메인 (고객 목록)
    @GetMapping({"", "/"})
    public String index(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        List<Customer> customers = customerService.findAll();
        model.addAttribute("customers", customers);
        model.addAttribute("totalCount", customerService.count());
        return "admin/index";
    }

    // 고객 목록 (페이징 + 검색 + 정렬)
    @GetMapping("/customer/list")
    public String customerList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "") String searchType,
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "latest") String sortType,
            HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }

        // 검색 조건에 맞는 총 고객 수
        int totalCount = customerService.countBySearch(searchType, keyword);

        // 페이징 계산
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (totalPages > 0 && page > totalPages) page = totalPages;

        // 페이지 블록 계산 (5개씩)
        int pageBlock = 5;
        int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
        int endPage = Math.min(startPage + pageBlock - 1, totalPages);

        // 고객 목록 조회
        List<Customer> customers = customerService.findByPage(page, PAGE_SIZE, searchType, keyword, sortType);

        model.addAttribute("customers", customers);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("pageSize", PAGE_SIZE);
        model.addAttribute("searchType", searchType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("sortType", sortType);

        return "admin/customer_list";
    }

    // 고객 등록 폼
    @GetMapping("/customer/register")
    public String customerRegisterForm(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        return "admin/customer_register";
    }

    // 고객 등록 처리
    @PostMapping("/customer/register")
    public String customerRegister(Customer customer, HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }

        // 고객ID 중복 체크
        if (customerService.existsById(customer.getCustomerId())) {
            model.addAttribute("error", "이미 존재하는 고객ID입니다.");
            model.addAttribute("customer", customer);
            return "admin/customer_register";
        }

        customerService.insert(customer);
        return "redirect:/admin/customer/list";
    }

    // 고객ID 중복 체크 (AJAX)
    @GetMapping("/customer/checkId")
    @ResponseBody
    public Map<String, Object> checkCustomerId(@RequestParam String customerId) {
        Map<String, Object> result = new HashMap<>();
        boolean exists = customerService.existsById(customerId);
        result.put("exists", exists);
        result.put("message", exists ? "이미 사용 중인 고객ID입니다." : "사용 가능한 고객ID입니다.");
        return result;
    }

    // 고객 상세
    @GetMapping("/customer/view")
    public String customerView(@RequestParam String id, HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        Customer customer = customerService.findById(id);
        model.addAttribute("customer", customer);
        return "admin/customer_view";
    }

    // 고객 수정 폼
    @GetMapping("/customer/edit")
    public String customerEditForm(@RequestParam String id, HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        Customer customer = customerService.findById(id);
        model.addAttribute("customer", customer);
        return "admin/customer_edit";
    }

    // 고객 수정 처리
    @PostMapping("/customer/edit")
    public String customerEdit(Customer customer, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        customerService.update(customer);
        return "redirect:/admin/customer/view?id=" + customer.getCustomerId();
    }

    // 고객 삭제 (비활성화)
    @GetMapping("/customer/delete")
    public String customerDelete(@RequestParam String id, HttpSession session,
                                 org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }

        int result = customerService.deactivate(id);
        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "고객이 비활성화되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "비활성화할 고객을 찾을 수 없습니다.");
        }

        return "redirect:/admin/customer/list";
    }
}
