package com.example.superreaders.views;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.example.superreaders.R;
import com.example.superreaders.SessionManagement;
import com.example.superreaders.retrofit.response.LoginResponse;
import com.example.superreaders.viewmodels.LoginViewModel;

public class LoginActivity extends AppCompatActivity {
    LoginViewModel viewModel;
    EditText txtUser;
    EditText txtPassword;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        Button buttonLogin = findViewById(R.id.buttonLogin);
        txtUser = findViewById(R.id.txtUser);
        txtPassword = findViewById(R.id.txtPassword);
        viewModel = ViewModelProviders.of(this).get(LoginViewModel.class);
        buttonLogin.setOnClickListener(v -> {
            viewModel.onLogin(txtUser.getText().toString(),txtPassword.getText().toString());

        });
        final Observer<String> observer = message ->{
            Toast.makeText(getApplicationContext(),message,Toast.LENGTH_LONG ).show();
        };
        final Observer<LoginResponse> observerLogin = user ->{
            if(!user.getToken().isEmpty()){
                SessionManagement session = new SessionManagement(getApplicationContext());
                session.createLoginSession(user);
                Intent intent = new Intent(this,MainActivity.class);
                startActivity(intent);
                this.finish();
            }
        };
        viewModel.getMessageResponse().observe(this,observer);
        viewModel.getUserLoged().observe(this,observerLogin);
    }
}
