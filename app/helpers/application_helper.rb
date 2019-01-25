module ApplicationHelper

	# ===== Helper to define gender list, connect to config/locales/en.yml
	def gender_lists 
		I18n.t(:gender_lists).map { |key, value| [ value, key ] } 
	end

end
