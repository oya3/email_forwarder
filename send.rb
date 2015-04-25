# coding: utf-8
require 'mail'

mail = Mail.new
options = {
  # :address => '10.6.102.204',
  #:address => '192.168.10.58',
  :address => '192.168.2.104',
  # :address => '172.17.10.58',
  :port => '3025',
}
mail.charset = 'utf-8'
mail.from "sender@oya3.net"
mail.to "kazunori@oya3.net, terje@oya3.net"
mail.subject "フォワードメールタイトル表示能力"
mail.body "フォワードメール本文表示能力"
mail.delivery_method(:smtp, options)
mail.deliver

