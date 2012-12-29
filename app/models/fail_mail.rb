# encoding: utf-8

class FailMail < ActiveRecord::Base
  def self.set_fail_mail( email )
    fail_mail = self.find_or_create_by_email( buffer.to ) 
    fail_mail.count += 1
    fail_mail.save
    fail_mail
  end
end
