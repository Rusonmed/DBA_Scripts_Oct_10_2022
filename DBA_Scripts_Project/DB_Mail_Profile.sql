--exec msdb.dbo.sp_send_dbmail

--Query Mail Profiles
exec msdb.dbo.sysmail_help_profile_sp

--Create a Database Mail account
EXECUTE msdb.dbo.sysmail_add_account_sp
	@account_name = 'OnMedDbNew_1000 Public Account',
	@description = 'Mail account for use by all database users.',
	@email_address = 'rdubas@onmed.com',
	@replyto_address = 'rdubas@onmed.com',
	@display_name = 'OnMedDbNew_1000 Automated Mailer',
	@mailserver_name = 'smtp.onmed.com';

--Create a Database Mail profile
EXECUTE msdb.dbo.sysmail_add_profile_sp
	@profile_name = 'OnMedDbNew_1000 Public Profile',
	@description = 'Profile used for adminsitrative mail.';

--Add the account to the profile
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
	@profile_name = 'OnMedDbNew_1000 Public Profile',
	@account_name = 'OnMedDbNew_1000 Public Account',
	@sequence_number =1;

--Grant access to the profile to all users in the msdb database
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
	@profile_name = 'OnMedDbNew_1000 Public Profile',
	@principal_name = 'public',
	@is_default = 1;

--Query Mail Profiles
exec msdb.dbo.sysmail_help_profile_sp

--Sending an e-mail message
EXEC msdb.dbo.sp_send_dbmail
	@profile_name = 'OnMedDbNew_1000 Public Profile',
	@recipients = 'rdubas@onmed.com',
	@body = 'The message were sent successfully.',
	@subject = 'Automated Success Message';

