# Release summary Add validate OTP for register new account
***Changes since last push from 20/7/2022 3:57 PM***

***Release date: 21/7/2022 5:27 AM***

## Add in Files:
- register-success.jsp
- `RegisterAccountController`

## Change in Files:
- validate-otp.jsp
	- Force required to enter OTP value
- `JavaMailUtils`
	- Change variables name
- `ForgotPasswordController`
	- Send out new session to let ValidateOtpController know where to validate otp from
- `RegisterController`
	- Move `addUser()` to `RegisterAccountController`
	- Add send OTP mail
	- Send account info to `RegisterAccountController` to `addUser()`
- `ValidateOtpController`
	- Fix for multible uses of OTP validation
- `AuthenFilter`
	- Allow guest to access `RegisterAccountController`


