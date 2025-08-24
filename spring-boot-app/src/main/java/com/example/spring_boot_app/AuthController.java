package com.example.spring_boot_app;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import java.io.IOException;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private SupabaseAuthService supabaseAuthService;

    /**
     * アカウント登録を行います
     * @param request アカウント情報
     * @param uriBuilder URI構築
     * @return 実行結果
     */
    @PostMapping("/register")
    public ResponseEntity<Map<String, Object>> register(@RequestBody AuthRequest request, UriComponentsBuilder uriBuilder) {
        String redirectTo = uriBuilder.replacePath("/").build().toUriString();
        Map<String, Object> result = supabaseAuthService.signUp(request.getEmail(), request.getPassword(), redirectTo);
        return result.containsKey("id") 
                ? ResponseEntity.ok(Map.of("message", "Registration successful. Please check your email for confirmation."))
                : ResponseEntity.badRequest().body(result);
    }

    /**
     * ログインを行います
     * @param request アカウント情報
     * @return 実行結果
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody AuthRequest request) {
        Map<String, Object> result = supabaseAuthService.signInWithPassword(request.getEmail(), request.getPassword());
        return result.containsKey("access_token")
                ? ResponseEntity.ok(result)
                : ResponseEntity.badRequest().body(result);
    }

    /**
     * Github認証にリダイレクトします
     * @param response HTTPレスポンス
     * @param uriBuilder URI構築
     */
    @GetMapping("/oauth2/github")
    public void redirectToGitHub(HttpServletResponse response, UriComponentsBuilder uriBuilder) throws IOException {
        String redirectTo = uriBuilder.replacePath("/").build().toUriString();
        String supabaseAuthGitHubUrl = supabaseAuthService.getGitHubSignInUrl(redirectTo);
        response.sendRedirect(supabaseAuthGitHubUrl);
    }

    /**
     * アカウント情報を取得します
     * @param request アカウント情報
     * @param uriBuilder URI構築
     */
    @PostMapping("/user")
    public ResponseEntity<Map<String, Object>> authUser(@RequestBody AuthRequest request) {
        Map<String, Object> user = supabaseAuthService.getUserByAccessToken(request.getAccessToken());
        return ResponseEntity.ok(Map.of("email", user.get("email")));
    }
}