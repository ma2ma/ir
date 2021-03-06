class Property
	include Mongoid::Document
	include SimpleEnum::Mongoid
	include ActionView::Helpers::TextHelper
	field :name
	field :show_name #属性显示名称
	field :description
	field :sort, :type => Integer, :default => 0 
    field :static, :type => Boolean, :default => false #属性是否为静态属性，即只能目录视图中使用
	field :require, :type => Boolean, :default => false #属性是否必填属性
	field :disable, :type => Boolean, :default => false #属性是否可用
	field :onlyread, :type => Boolean, :default =>false #暂时废弃。属性只读，可以在列表中和view中调用与查看，修改页面中只显示不可以修改。
	field :view_in_grid, :type => Boolean , :default => false #是否在目录的管理列表中显示
	field :edit_in_grid, :type => Boolean , :default => false #是否在目录的管理列表中编辑
	field :find_in_grid, :type => Boolean , :default => false #是否在目录的管理列表中查找
	field :be_identify,:type => Boolean,:default => false #是否为认证字段，目前只有多选类型可以设置为认证字段
	field :identify_color, :default => '#f39c12'
	field :property_by_identify, :type => Array,:default => []
	#属性类型
	as_enum :type, :string => 1, :text => 2, :integer => 3, :number => 4, 
	:embed_html => 5, :enum => 6, :muli_enum  => 7, :file => 8, 
	:pdf => 9, :picture => 10, :video => 11, :music => 12, 
	:time => 13, :date =>14, :data_sheet => 15, :array => 16,:email => 17,:link => 18,:bool => 19
	#属性的继承属性
	as_enum :inherit_type, [:public, :private, :protect ], :field => { :type => Integer, :default => 1 }

	#自动填充类属性
	field :auto_fill, :type => Boolean, :default => false #是否为自动填充属性（关联属性），可以根据其他几个属性的值计算得到，在与其关联的属性修改的时候自动修改。
	field :auto_fill_function #自动填充使用的函数，可以通过其他字段计算出该字段的值

	#可选字段
	field :max_value, :type => Integer
	field :min_value, :type => Integer
	field :front_ext #录入时的前扩展
	field :back_ext #录入时的后扩展
	field :string_format #字符串匹配的格式，要求正则表达式
	field :embed_html_markdown, :type => Boolean, :default => true #扩展内容使用markdown还是富文本，预设，先不用
	field :enum_option, :type => Array
	field :file_type, :type => Array,:default => []
	field :data_x, :type => Integer #数据表类型的列数
	field :data_y, :type => Integer #数据表类型的行数
	scope :enable_not_static, where(static: false,disable: false)
	scope :enable_static, where(static: true,disable: false)
	scope :enable_all, where(disable: false)
	scope :grid_show, where(static: false,disable: false,view_in_grid: true)
	scope :grid_find, where(static: false,disable: false,find_in_grid: true)
	scope :identify_property, where(disable: false,be_identify: true)
	scope :tree_all_property, where(:inherit_type_cd.ne => 1)
	scope :tree_public_property, where(:inherit_type_cd => 0)
	embedded_in :folder

	validates_presence_of :name,:show_name,:type,:static,:require,:disable,:view_in_grid,:inherit_type
	validates_uniqueness_of :name,message: "同一目录属性重名！"
	validate :val_name
	before_save do |property|
		property.static = (property.static == "1" || property.static == true) ? true : false
		property.disable = (property.disable == "1" || property.disable == true) ? true : false
		property.require = (property.require == "1" || property.require == true) ? true : false
		property.onlyread = (property.onlyread == "1" || property.onlyread == true) ? true : false
		property.view_in_grid = (property.view_in_grid == "1" || property.view_in_grid == true) ? true : false
		property.edit_in_grid = (property.edit_in_grid == "1" || property.edit_in_grid == true) ? true : false
		property.find_in_grid = (property.find_in_grid == "1" || property.find_in_grid == true) ? true : false
		property.be_identify = (property.be_identify == "1" || property.be_identify == true) ? true : false
		#html_safe
		property.name = strip_tags property.name
		property.show_name = strip_tags property.show_name
		property.description = strip_tags property.description
		property.front_ext = strip_tags property.front_ext
		property.back_ext = strip_tags property.back_ext
		property.string_format =  strip_tags property.string_format
		
		true
	end
	def type_name
		PropertyType.where(type_view_cd: self.type_cd).first.name
	end
	def type_image
		#logger.debug { "#{self.name}" }
		#logger.debug { "!!!!!#{self.name}!!!!!!!!#{self.type_cd}!!!!!!!!!!" } unless PropertyType.where(type_view_cd: self.type_cd).first
		PropertyType.where(type_view_cd: self.type_cd).first.image_path
	end
	def all_oper
		PropertyType.where(type_view_cd: self.type_cd).first.property_opers
	end
	def only_name?(name)
		!self.folder.properties.where(name: name).exists?
	end
	def req?
		self.require
	end
	def have_max?
		!self.max_value.nil?
	end
	def have_min?
		!self.min_value.nil?
	end
	def have_front?
		!self.front_ext.blank?
	end
	def have_back?
		!self.back_ext.blank?
	end
	def get_show_name
		self.show_name.blank? ? self.name : self.show_name
	end
	def is_inherit?
		@inherit ? true : false
	end
	def set_inherit
		@inherit = true
	end
	def get_color
		color='primary'
		color='success' if self.view_in_grid
		color='danger' if self.require
		color='warning' if self.static
		color='info' if self.disable
		color='default' if  self.is_inherit?

		color
	end
	def get_input_color
		color='primary'
		color='default' if  self.is_inherit?
		color='success' if self.view_in_grid
		#color='warning' if self.static
		#color='info' if self.disable
		color='danger' if self.require
		color
	end
	def get_select_color
		color='primary'
		color='default' if  self.is_inherit?
		color='success' if self.view_in_grid
		color='warning' if self.static
		#color='info' if self.disable
		color='danger' if self.require
		color
	end
	def is_identify?
		self.muli_enum? && self.be_identify ? true : false
	end
	def static_css
		self.static ? 'is-static' : ''
	end
	def set_clear_indentify_flag(property_id)
		if !@clear_indentify_flag && self.property_by_identify.include?(property_id)
			@clear_indentify_flag = true
		end
		self
	end
	def clear_indentify?
		@clear_indentify_flag ? true : false
	end
	private
	def val_name
		if folder.parent_folder && folder.parent_folder.tree_have_property?(name)
			errors.add(:name, "父目录中有同名属性！")
		end
	end
end
