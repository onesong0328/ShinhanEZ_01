package com.shinhanez.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shinhanez.domain.Customer;
import com.shinhanez.domain.InsuredPerson;
import com.shinhanez.domain.ShezUser;
import com.shinhanez.service.CustomerService;
import com.shinhanez.service.InsuredPersonService;

/**
 * 관리자 컨트롤러
 * - 고객(보험자) CRUD
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private CustomerService customerService;
    
    @Autowired
    private InsuredPersonService insuredPersonService;

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

    // 고객 목록 (페이징 + 정렬 + 검색)
    @GetMapping("/customer/list")
    public String customerList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "latest") String sort,
            @RequestParam(required = false) String keyword,
            HttpSession session, Model model) {
        
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        
        List<Customer> customers;
        int totalCount;
        
        // 검색어 있으면 검색, 없으면 전체 조회
        if (keyword != null && !keyword.trim().isEmpty()) {
            customers = customerService.findBySearch(keyword.trim(), page, size);
            totalCount = customerService.countBySearch(keyword.trim());
        } else {
            customers = customerService.findByPage(page, size, sort);
            totalCount = customerService.count();
        }
        
        // 페이징 정보 계산
        int totalPages = (int) Math.ceil((double) totalCount / size);
        int startPage = ((page - 1) / 10) * 10 + 1;
        int endPage = Math.min(startPage + 9, totalPages);
        
        model.addAttribute("customers", customers);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("size", size);
        model.addAttribute("sort", sort);
        model.addAttribute("keyword", keyword);
        
        return "admin/customer_list";
    }
    
    // 고객 등록 폼
    @GetMapping("/customer/register")
    public String customerRegisterForm(HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        return "admin/customer_register";
    }
    
    // 고객 등록 처리
    @PostMapping("/customer/register")
    public String customerRegister(Customer customer, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        customerService.insert(customer);
        return "redirect:/admin/customer/list";
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

    // 고객 삭제
    @GetMapping("/customer/delete")
    public String customerDelete(@RequestParam String id, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        customerService.delete(id);
        return "redirect:/admin/customer/list";
    }
    
    // ========================================
    // 피보험자 관리
    // ========================================
    
    // 피보험자 목록 (페이징 + 정렬 + 검색)
    @GetMapping("/insured/list")
    public String insuredList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "latest") String sort,
            @RequestParam(required = false) String keyword,
            HttpSession session, Model model) {
        
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        
        List<InsuredPerson> insuredList;
        int totalCount;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            insuredList = insuredPersonService.findBySearch(keyword.trim(), page, size);
            totalCount = insuredPersonService.countBySearch(keyword.trim());
        } else {
            insuredList = insuredPersonService.findByPage(page, size, sort);
            totalCount = insuredPersonService.count();
        }
        
        int totalPages = (int) Math.ceil((double) totalCount / size);
        int startPage = ((page - 1) / 10) * 10 + 1;
        int endPage = Math.min(startPage + 9, totalPages);
        
        model.addAttribute("insuredList", insuredList);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("size", size);
        model.addAttribute("sort", sort);
        model.addAttribute("keyword", keyword);
        
        return "admin/insured_list";
    }
    
    // 피보험자 상세
    @GetMapping("/insured/view")
    public String insuredView(@RequestParam String id, HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        InsuredPerson insured = insuredPersonService.findById(id);
        model.addAttribute("insured", insured);
        return "admin/insured_view";
    }
    
    // 피보험자 등록 폼
    @GetMapping("/insured/register")
    public String insuredRegisterForm(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        // 고객 목록 (가입고객 선택용)
        List<Customer> customers = customerService.findAll();
        model.addAttribute("customers", customers);
        return "admin/insured_register";
    }
    
    // 피보험자 등록 처리
    @PostMapping("/insured/register")
    public String insuredRegister(InsuredPerson insuredPerson, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        insuredPersonService.insert(insuredPerson);
        return "redirect:/admin/insured/list";
    }
    
    // 피보험자 수정 폼
    @GetMapping("/insured/edit")
    public String insuredEditForm(@RequestParam String id, HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        InsuredPerson insured = insuredPersonService.findById(id);
        List<Customer> customers = customerService.findAll();
        model.addAttribute("insured", insured);
        model.addAttribute("customers", customers);
        return "admin/insured_edit";
    }
    
    // 피보험자 수정 처리
    @PostMapping("/insured/edit")
    public String insuredEdit(InsuredPerson insuredPerson, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        insuredPersonService.update(insuredPerson);
        return "redirect:/admin/insured/view?id=" + insuredPerson.getInsuredId();
    }
    
    // 피보험자 삭제
    @GetMapping("/insured/delete")
    public String insuredDelete(@RequestParam String id, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/member/login?error=auth";
        }
        insuredPersonService.delete(id);
        return "redirect:/admin/insured/list";
    }
}
