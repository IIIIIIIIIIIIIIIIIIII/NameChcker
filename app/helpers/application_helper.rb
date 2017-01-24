module ApplicationHelper
	include SessionsHelper

	def full_title(provided=nil)
		base_title = "Name Checker"
		if provided.blank?
			return base_title
		else
			return "#{base_title} | #{provided}"
		end
	end

	def link_to_add_fields(name, f, association)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, :child_index => id) do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
		link_to(name, "#", :class => "add_fields", data: {:id => id, :fields => fields.gsub("\n", '')})
	end

	def names_tracked
		names = RsName.all.group_by{|r| r.notified?}
		"Currently tracking #{pluralize(names[false].count, "name")}. #{pluralize(names[true].count, "name")} found so far."
	end

end
