# coding: utf-8
require 'mail'
require 'pry'

mail = Mail.new

options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => "smtp.gmail.com",
            :user_name            => 'terje@oya3.net',
            :password             => 'xxx',
            :authentication       => :plain,
            :enable_starttls_auto => true
          } 
mail.charset = 'utf-8'
mail.from "terje@oya3.net"
mail.to "kazunori@oya3.net"
mail.subject "メールタイトル"
mail.body "メール本文"
mail.delivery_method(:smtp, options)
mail.deliver
