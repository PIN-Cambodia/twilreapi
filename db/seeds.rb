account = Account.without_permissions.first_or_create!
access_token = account.access_token || account.create_access_token!

@format = ENV["FORMAT"] || "human"
@output = ENV["OUTPUT"] || "all"

def human_format?
  @format == "human"
end

def basicauth_format?
  @format == "basicauth"
end

def output_all?
  @output == "all"
end

def output_user?
  @output == "user" || output_all?
end

def output_admin?
  @output == "admin" || output_all?
end

if output_user?
  if basicauth_format?
    print "#{account.sid}:#{account.auth_token}"
  else
    puts "User Account SID:         #{account.sid}"
    puts "User Account Auth Token:  #{account.auth_token}"
  end
end

if ENV["CREATE_ADMIN_ACCOUNT"].to_i == 1
  if !(raw_account_permissions = ENV["ADMIN_ACCOUNT_PERMISSIONS"])
    puts "Specify ADMIN_ACCOUNT_PERMISSIONS=comma_separated_list_of_permissions"
    puts "Possible Permissions are: #{Account.values_for_permissions.to_sentence}"
  else
    account_permissions = raw_account_permissions.split(",").map(&:to_sym)
    account_permissions = Account.values_for_permissions if account_permissions == [:all]

    account_permissions = account_permissions.zip(
      account_permissions
    ).to_h.slice(
      *Account.values_for_permissions
    ).values

    admin_account = (account_permissions.any? ? Account.with_permissions(*account_permissions) : Account.without_permissions).first_or_initialize

    if admin_account.new_record?
      admin_account.permissions = account_permissions
      admin_account.save!
    end

    admin_account_access_token = admin_account.access_token || admin_account.create_access_token!

    if output_admin?
      if basicauth_format?
        print "#{admin_account.sid}:#{admin_account.auth_token}"
      else
        puts "Admin Account SID:        #{admin_account.sid}"
        puts "Admin Account Auth Token: #{admin_account.auth_token}"
      end
    end
  end
end
