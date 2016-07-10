ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: '587',
    authentication: :plain,
    user_name: Figaro.env.SENDGRID_USERNAME,
    password: Figaro.env.SENDGRID_PASSWORD,
    domain: 'expense-pro.com',
    enable_starttls_auto: true
}