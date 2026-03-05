# Authentication Feature

## 📁 Structure

```
lib/features/auth/
├── controllers/
│   └── auth_controller.dart      # State management for authentication
├── models/
│   ├── user_model.dart          # User data model
│   └── auth_models.dart         # Request/Response models
├── screens/
│   ├── login_screen.dart        # Login screen
│   ├── signup_screen.dart       # Sign up screen
│   ├── forgot_password_screen.dart # Forgot password screen
│   ├── otp_verification_screen.dart # OTP verification screen
│   └── reset_password_screen.dart # Reset password screen
├── services/
│   └── auth_service.dart        # API service for authentication
└── README.md                    # This file
```

## 🔐 Authentication Flow

### 1. **Login Flow**
```
Login Screen → Validate → API Call → Success/Error → Navigate to Home
```

### 2. **Sign Up Flow**
```
Sign Up Screen → Validate → API Call → Success/Error → Navigate to Home
```

### 3. **Forgot Password Flow**
```
Forgot Password → Send OTP → OTP Verification → Reset Password → Login
```

## 📱 Screens

### **Login Screen**
- Email and password fields
- Form validation
- Loading states
- Error/success messages
- Navigation to sign up and forgot password

### **Sign Up Screen**
- Name, email, phone, password fields
- Password confirmation
- Form validation
- Loading states
- Error/success messages

### **Forgot Password Screen**
- Email field
- Send OTP functionality
- Navigation to OTP verification

### **OTP Verification Screen**
- 6-digit OTP input
- Auto-focus between fields
- Resend OTP functionality
- Navigation to reset password

### **Reset Password Screen**
- New password and confirmation fields
- Form validation
- Navigation back to login

## 🔧 API Endpoints

### **Base URL**: `https://api.awan.com`

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/auth/login` | User login |
| POST | `/auth/register` | User registration |
| POST | `/auth/forgot-password` | Send OTP for password reset |
| POST | `/auth/verify-otp` | Verify OTP code |
| POST | `/auth/reset-password` | Reset password with OTP |

## 📊 Request/Response Models

### **Login Request**
```dart
{
  "email": "user@example.com",
  "password": "password123"
}
```

### **Sign Up Request**
```dart
{
  "name": "John Doe",
  "email": "user@example.com",
  "password": "password123",
  "phone": "+1234567890" // Optional
}
```

### **Auth Response**
```dart
{
  "success": true,
  "message": "Login successful",
  "token": "jwt_token_here",
  "user": {
    "id": "user_id",
    "name": "John Doe",
    "email": "user@example.com"
  }
}
```

## 🎯 Features

### ✅ **Form Validation**
- Email format validation
- Password strength validation
- Required field validation
- Password confirmation matching
- OTP length validation

### ✅ **State Management**
- Loading states for all operations
- Error message handling
- Success message handling
- Form controller management

### ✅ **User Experience**
- Auto-focus in OTP fields
- Password visibility toggle
- Loading indicators
- Error/success feedback
- Smooth navigation flow

### ✅ **Security**
- Token storage in secure storage
- Password obscuring
- Input validation
- API error handling

## 🔄 Navigation Flow

```
Onboarding → Login → Home
           ↓
         Sign Up → Home
           ↓
    Forgot Password → OTP → Reset Password → Login
```

## 🛠️ Usage

### **1. Initialize Auth Controller**
```dart
ChangeNotifierProvider(create: (_) => AuthController())
```

### **2. Access in Widget**
```dart
Consumer<AuthController>(
  builder: (context, controller, child) {
    return ElevatedButton(
      onPressed: controller.isLoading ? null : () async {
        final success = await controller.login();
        if (success) {
          // Navigate to home
        }
      },
      child: controller.isLoading 
        ? CircularProgressIndicator() 
        : Text('Login'),
    );
  },
)
```

### **3. Form Validation**
```dart
TextFormField(
  controller: controller.emailController,
  validator: controller.validateEmail,
  decoration: InputDecoration(labelText: 'Email'),
)
```

## 🔧 Configuration

### **API Base URL**
Update the base URL in `auth_service.dart`:
```dart
static const String baseUrl = 'https://your-api-url.com';
```

### **Storage Keys**
Token and user data are stored using `StorageService`:
- `auth_token`: JWT token
- `user_email`: User email for OTP flow

## 🚀 Future Enhancements

- [ ] Biometric authentication
- [ ] Social login (Google, Facebook)
- [ ] Remember me functionality
- [ ] Auto-login on app start
- [ ] Session timeout handling
- [ ] Multi-factor authentication
- [ ] Account verification
- [ ] Profile management
