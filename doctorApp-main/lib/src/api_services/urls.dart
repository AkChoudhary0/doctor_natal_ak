import '../config/app_configs.dart';

final String baseUrl = AppConfigs.baseUrl;
final String apiBaseUrl = AppConfigs.apiBaseUrl;
final String mediaUrl = AppConfigs.mediaUrl;

///---fcm
const String fcmService = 'https://fcm.googleapis.com/fcm/send';

///---auth
// String signUpWithEmailURL = apiBaseUrl + 'signup-email';
String signUpWithEmailURL = '${apiBaseUrl}auth/register';
String signInWithEmailURL = '${apiBaseUrl}auth/login';
String socialLoginURL = '${apiBaseUrl}auth/social_login';
String loginWithOtpURL = '${apiBaseUrl}login-signup';
String signOutURL = '${apiBaseUrl}auth/logout';
String deleteAccountURL = '${apiBaseUrl}auth/delete_account';

///---logged-in-user
String getLoggedInUserUrl = '${apiBaseUrl}auth/user';

String contactUsUrl = '${apiBaseUrl}contact';

///---payment-method
String paymentMethodUrl = '${apiBaseUrl}execute-payment';
String jazzCashPaymentUrl = '${apiBaseUrl}makeJazzcashPayment';
// String getAppointmentPaymentStatusUrl = baseUrl + 'getAppointmentStatus';
String getPaymentMethodsUrl = '${apiBaseUrl}payment_methods';

//---edit-or-update-profile
String editUserProfileURL = '${apiBaseUrl}doctors/update_general_info';
// String editUserProfileExperienceURL = apiBaseUrl + 'doctors/doctor_experiences';
String addEditUserProfileEducationURL =
    '${apiBaseUrl}doctors/doctor_educations';
String addEditUserProfileCertificateURL =
    '${apiBaseUrl}doctors/doctor_certifications';
String addEditUserProfileExperienceURL =
    '${apiBaseUrl}doctors/doctor_experiences';
String addEditUserProfilePodcastURL = '${apiBaseUrl}doctors/doctor_podcasts';
String addEditUserProfileEventURL = '${apiBaseUrl}doctors/doctor_events';
String addEditUserProfileBlogURL = '${apiBaseUrl}doctors/doctor_posts';

//---get-profile-certificate
String getUserProfileCertificateURL =
    '${apiBaseUrl}doctors/doctor_certifications';
//---get-profile-experiences
String getUserProfileExperiencesURL = '${apiBaseUrl}doctors/doctor_experiences';
//---get-profile-Education
String getUserProfileEducationsURL = '${apiBaseUrl}doctors/doctor_educations';
//---get-profile-Podcasts
String getUserProfilePodcastsURL = '${apiBaseUrl}doctors/doctor_podcasts';
//---get-profile-Events
String getUserProfileEventsURL = '${apiBaseUrl}doctors/doctor_events';
//---get-profile-Blogs
String getUserProfileBlogsURL = '${apiBaseUrl}doctors/doctor_posts';

//---get-EHR-Doctors-Diseaseas
String getDoctorsEHRDiseasesURL =
    '${apiBaseUrl}doctors/electronic_health_record/diseases';
String getDoctorsEHRPatientHealthsURL =
    '${apiBaseUrl}doctors/electronic_health_record/patient_healths';
String getDoctorsEHRMedicalTestsURL =
    '${apiBaseUrl}doctors/electronic_health_record/medical_tests';
String addDoctorsEHRPrescriptionURL =
    '${apiBaseUrl}doctors/electronic_health_record/add_prescription_appointment';
String addDoctorsEHRMedicineURL =
    '${apiBaseUrl}doctors/electronic_health_record/add_medicine_appointment';
String deleteDoctorsEHRMedicineURL =
    '${apiBaseUrl}doctors/electronic_health_record/delete_medicine_appointment';

///---consultant-profile-by-id
String getDoctorProfileUrl = '${apiBaseUrl}doctors/';

///---featured
String getFeaturedEvents = '${apiBaseUrl}featured_events';
String getFeaturedDoctors = '${apiBaseUrl}featured_doctors';

///---all listings
String getAllDoctors = '${apiBaseUrl}filter_doctors';
String getAllBlogsPosts = '${apiBaseUrl}filter_posts';
String getAllEvents = '${apiBaseUrl}filter_events';

///---categories
String getDoctorCategoriesURL = '${apiBaseUrl}doctor_categories';

///---book-appointment
String getScheduleAvailableDaysURL =
    '${apiBaseUrl}get-scheduled-available-days';
String getScheduleSlotsForMenteeUrl = '${apiBaseUrl}get-date-schedule';
String bookAppointmentUrl = '${apiBaseUrl}bookAppointment';

///---appointment-log-user
String getAppointmentsDetailURL = '${apiBaseUrl}appointmentDetails';

///---doctor-reviews
String getDoctorReviews = '${apiBaseUrl}filter_doctor_reviews';

/// wallet
String getWalletBalanceURL = '${apiBaseUrl}get_current_balance';
String getWalletTransactionURL = '${apiBaseUrl}get_wallet_transactions';
String getWalletWithdrawalURL = '${apiBaseUrl}get_wallet_withdrawls';
String withdrawAmountURL = '${apiBaseUrl}withdraw_amount';

/// rating
String createRatingUrl = '${apiBaseUrl}create-rating';
String getExistRatingUrl = '${apiBaseUrl}rating-exist-appointment';

///---agora
String getAgoraTokenUrl = '${apiBaseUrl}doctors/api_generate_agora_token';

///---Make Agora Call
String makeAgoraCall = '${apiBaseUrl}doctors/api_make_agora_call';

///--- Send Call Notification
String sendCallNotification = '${apiBaseUrl}doctors/api_send_notification';

///---send-message
String sendSMSUrl = '${apiBaseUrl}send-sms';

///---get-device-id
String fcmUpdateUrl = '${apiBaseUrl}fcm-store-token';
String fcmGetUrl = '${apiBaseUrl}fcm-get-tokens';

///---chat messages
String getMessagesUrl = '${apiBaseUrl}doctors/api_get_chat_messages/';
String sendMessageUrl = '${apiBaseUrl}doctors/api_send_chat_message';

///---service chat messages
String getServiceMessagesUrl =
    '${apiBaseUrl}doctors/api_get_service_chat_messages/';
String sendServiceMessageUrl =
    '${apiBaseUrl}doctors/api_service_send_chat_message';

///---reset-password
String forgotPasswordUrl = '${apiBaseUrl}auth/forgot_password';
String newPasswordUrl = '${apiBaseUrl}reset-password';

/// All Settings
String getAllSettingUrl = '${apiBaseUrl}settings';

/// All Themes
String getThemesUrl = '${apiBaseUrl}themes';

/// All Languages
String getAllLanguagesUrl = '${apiBaseUrl}get_all_languages';

/// Get Terms and Conditions
String getTermsConditionsUrl = '${apiBaseUrl}terms_conditions';

// Generate Appointment Schedule Slots Doctor
String generateAppointmentScheduleSlotsUrl =
    '${apiBaseUrl}doctors/save_appointment_schedules';

// Generate Appointment Schedule Slots for Single Day Doctor
String generateAppointmentScheduleSlotsForSingleDayUrl =
    '${apiBaseUrl}doctors/add_new_appointment_schedules';

// Get Appointment Commission
String getAppointmentScheduleCommissionUrl =
    '${apiBaseUrl}doctors/get_appointment_commission';

String deleteAppointmentScheduleSlotsUrl =
    '${apiBaseUrl}doctors/delete_appointment_slots';

// Get Appointment Schedule Slots Doctor
String getAppointmentScheduleSlotsUrl =
    '${apiBaseUrl}doctors/api_appointment_schedules';

// Get Doctor Appointment History
String getDoctorAppointmentHistory =
    "${apiBaseUrl}doctors/get_filter_appointment_logs";

// Get Doctor Booked Services History
String getDoctorBookedServices =
    "${apiBaseUrl}doctors/get_filter_booked_services";

// Update Appointment Status Code
String updateAppointmentStatusCodeURL =
    "${apiBaseUrl}doctors/update_appointment_status/";

// Update Booked Service Status Code
String updateBookedServiceStatusCodeURL =
    "${apiBaseUrl}doctors/update_booked_service_status/";

// Content Pages URls
String contentPagesURL = "${apiBaseUrl}company_page";

// Open Web View For Pricing Plan
String webViewForPricingPlanURL = "${baseUrl}pricing/doctor";
