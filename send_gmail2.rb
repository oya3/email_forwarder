# coding: utf-8
require 'eventmachine'

# 
# eventmachineを利用して送信はできない。やりかたわからん。
# 

email = EM::Protocols::SmtpClient.send(
  :domain => 'smtp.gmail.com',
  :host => 'smtp.gmail.com',
  :port => '587',
  :starttls => false, # true, # use ssl
  :auth => {:type => :plain, :username => "terje@oya3.net", :password => "xxx"},
  :from => "terje@oya3.net",
  :to => "kazunori@oya3.net",
  :header => {"Subject" => "メールテスト"},
  :body => "メール本文"
#  :content => current.data
)

email.callback do
  puts "#{Time.now}:forwarding OK."
end

email.errback do |e|
  puts "#{Time.now}:forwarding ERROR."
end

