module ApplicationHelper
	def full_title(title='')
		base_title=Plebbit
		if title.empty?
			base_title
		else
			title + ' | Plebbit'
		end
	end
end
