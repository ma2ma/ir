# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$("#add_folder_group").select2
		createSearchChoice: (term, data) ->
			if $(data).filter( -> this.text.localeCompare(term) is 0 ).length is 0
				{id:term, text:term}
		multiple: false,
		data: ->
			result = JSON.parse $("#add_folder_group_data").val()
			li = []
			for item in result
				li.push({id: item['_id']['$oid'],text: item['name'] })
			return { text:'text', results: li }

	$("#edit_folder_group").select2
		createSearchChoice: (term, data) ->
			if $(data).filter( -> this.text.localeCompare(term) is 0 ).length is 0
				{id:term, text:term}
		multiple: false,
		data: ->
			result = JSON.parse $("#edit_folder_group_data").val()
			li = []
			for item in result
				li.push({id: item['_id']['$oid'],text: item['name'] })
			return { text:'text', results: li }
	$("#edit_folder_group").select2 "val", $("#edit_folder_group_value").val()
	# $("#add_folder_submit").click  (event) ->
 #  		if $(this).parent().parent().parent().valid() is false
 #    		#$("#error-text").text "填写信息不完整。"
 #    		return false

    # $("#edit_folder_submit").click  (event) ->
  		# if $(this).parent().parent().parent().valid() is false
    # 		#$("#error-text").text "填写信息不完整。"
    # 		return false
	$("#add_folder_tile_color_group").hide()
	$('#add_folder_tile').on "ifChanged", (event) ->
    	$("#add_folder_tile_color_group").slideToggle()

    if !$('#modify_folder_tile').parent().hasClass("checked")
    	$("#modify_folder_tile_color_group").hide()
    	
	$('#modify_folder_tile').on "ifChanged", (event) ->
    	$("#modify_folder_tile_color_group").slideToggle()
    #Make the dashboard widgets sortable Using jquery UI
	$(".connectedSortable").sortable(
	  placeholder: "sort-highlight"
	  connectWith: ".connectedSortable"
	  handle: ".box-header, .nav-tabs"
	  forcePlaceholderSize: true
	  dropOnEmpty: true
	  zIndex: 999999
	).disableSelection()
	$(".box-header, .nav-tabs").css "cursor", "move"

	##############################################
	#配置文档属性页面
	##############################################
	hide_option =  -> 
		$("#add_property_maxmin_pane").hide();
		$("#add_property_strformat_pane").hide();
		$("#add_property_ext_pane").hide();
		$("#add_property_options_pane").hide();
		$("#add_property_mutleselect_pane").hide();
		$("#add_property_xy_pane").hide();
		$("#add_property_filetype_pane").hide();
		$("#add_property_mutleselectcolor_pane").hide();
		$("#add_property_mutleselectproperty_pane").hide();

	fix_custom_option = (arg) ->
		hide_option();
		switch arg
			when "string"
				$("#add_property_maxmin_pane").slideDown();
				$("#add_property_ext_pane").slideDown();
				$("#add_property_strformat_pane").slideDown();
			when "text"
				$("#add_property_maxmin_pane").slideDown();
				$("#add_property_strformat_pane").slideDown();
			when "integer","number"
				$("#add_property_maxmin_pane").slideDown();
				$("#add_property_ext_pane").slideDown();
			when "enum"
				$("#add_property_options_pane").slideDown();
			when "muli_enum"
				$("#add_property_options_pane").slideDown();
				$("#add_property_mutleselect_pane").slideDown();
				$("#add_property_mutleselectcolor_pane").slideDown();
				$("#add_property_mutleselectproperty_pane").slideDown();
			when "file"
				$("#add_property_maxmin_pane").slideDown();
				$("#add_property_filetype_pane").slideDown();
			when "data_sheet"
				$("#add_property_xy_pane").slideDown();
			when "array","pdf","picture","video","music"
				$("#add_property_maxmin_pane").slideDown();
			else
	fill_modify_enum_options = (arg) ->
    if(arg.attr('value')=='[]')
        arg.val("")
        return []
    else
        JSON.parse(arg.attr('value'))

	$("#enum_options").tagsManager hiddenTagListName: "addhidden-property[enum_option]"
	$("#file_type").tagsManager hiddenTagListName: "addhidden-property[file_type]"
	
	fix_custom_option('string');
	$('#add_property_custom_pane').hide();
	$('#add_property_custom').on "switch-change", (e, data) ->
        $('#add_property_custom_pane').slideToggle()

    $('#add_property_adv_pane').hide();
	$('#add_property_adv').on "switch-change", (e, data) ->
        $('#add_property_adv_pane').slideToggle()

    $("#add_property_type").on 'change', (e)->
    	fix_custom_option(e.val)

    $('.modify_property_adv_pane').hide();
	$('.modify_property_adv').on "switch-change", (e, data) ->
		$(data.el).parent().parent().parent().parent().next().next("div").slideToggle()

	$(".modify_property_enum_options").each ->
        $(this).tagsManager({prefilled: fill_modify_enum_options($(this))})

	$(".modify_property_file_type").each ->
        $(this).tagsManager({prefilled: fill_modify_enum_options($(this))})

    #收起所有属性
   #$(".property-box").hide();
   $(".property-box-g").addClass("collapsed-box");

   # to set summernote object
   if $('#folder_doc_default_content')[0]
     summer_note = $('#folder_doc_default_content')
     summer_note.summernote
       height: ($(window).height() - 300),
       lang: 'zh-CN',
       style: 'cosmo',
       focus: true,
       oninit: ->
        insertBtn = "<button id='insertTagBtn' data-toggle='modal' data-target='#insert-property-modal' type='button' class='btn btn-primary btn-sm btn-small' title='插入属性' data-event='something' tabindex='-1'><i class=' fa fa-gears'></i></button>"
        partiBtn =  "<button id='insertPartitonBtn' type='button' class='btn btn-default btn-sm btn-small' title='' data-event='something' tabindex='-1'><i class=' fa fa-cut'></i></button>"
        fileGroup = "<div class=\"note-property btn-group\">" + insertBtn + partiBtn + "</div>"
        $(fileGroup).prependTo $(".note-toolbar")
        $("#insertTagBtn").tooltip
          container: "body"
          placement: "bottom"
        $("#insertPartitonBtn").tooltip
          container: "body"
          placement: "bottom"
        $('#insertPartitonBtn').click ->
          if !$('#summary_line')[0]
            document.execCommand('insertHTML',false,'&nbsp;<button id=\'summary_line\' type=\'button\' class=\'btn btn-default btn-sm has_tooltip\' data-toggle=\'tooltip\' data-placement=\'top\' title=\'摘要分割点\'><i class=\'fa fa-angle-double-right\'></i></button>&nbsp;');
            $('#summary_line').tooltip();
        return
     summer_note.code summer_note.val()
     summer_note.closest('form').submit ->
       summer_note.val summer_note.code()
     true
   if $('#document_content_have_attr')[0]
     summer_note = $('#document_content_have_attr')
     summer_note.summernote
       height: ($(window).height() - 300),
       lang: 'zh-CN',
       style: 'cosmo',
       focus: true,
       oninit: ->
        insertBtn = "<button id='insertTagBtn' data-toggle='modal' data-target='#insert-property-modal' type='button' class='btn btn-primary btn-sm btn-small' title='插入属性' data-event='something' tabindex='-1'><i class=' fa fa-gears'></i></button>"
        partiBtn =  "<button id='insertPartitonBtn' type='button' class='btn btn-default btn-sm btn-small' title='' data-event='something' tabindex='-1'><i class=' fa fa-cut'></i></button>"
        fileGroup = "<div class=\"note-property btn-group\">" + insertBtn + partiBtn + "</div>"
        $(fileGroup).prependTo $(".note-toolbar")
        $("#insertTagBtn").tooltip
          container: "body"
          placement: "bottom"
        $("#insertPartitonBtn").tooltip
          container: "body"
          placement: "bottom"
        $('#insertPartitonBtn').click ->
          if !$('#summary_line')[0]
            document.execCommand('insertHTML',false,'&nbsp;<button id=\'summary_line\' type=\'button\' class=\'btn btn-default btn-sm has_tooltip\' data-toggle=\'tooltip\' data-placement=\'top\' title=\'摘要分割点\'><i class=\'fa fa-angle-double-right\'></i></button>&nbsp;');
            $('#summary_line').tooltip();
        return
     summer_note.code summer_note.val()
     summer_note.closest('form').submit ->
       summer_note.val summer_note.code()
     true
    $('.is-a-property').tooltip({container: 'body'})
    #配置共享属性开放权限
    $('.select-share-property').select2()
    $(".select-share-property").on "change", (e) ->
    	sel_val = e.val
    	$.ajax
    		url: $(this).data('url')
    		type: "put"
    		data: {inherit_type: sel_val}
    		success: (result) ->
    			if result['status'] == 'true'
    				Messenger().post
    					message: result['message'],
    					type: 'success',
    					showCloseButton: true
    			else
    				Messenger().post
    					message: result['message'],
    					type: 'error',
    					showCloseButton: true

    	false

    $('.set-parent-visiable').on "switch-change", (e, data) ->
      $.ajax
        url: $(this).data('url')
        type: "patch"
        data: {visiable: data.value}
        success: (result) ->
          if result['status'] == 'true'
            Messenger().post
              message: result['message'],
              type: 'success',
              showCloseButton: true
          else
            Messenger().post
              message: result['message'],
              type: 'error',
              showCloseButton: true

      false

    $('.copy_child_doc').click ->
      #alert $(this).data('docid')
      $.ajax
        url: $(this).data('url')
        type: "post"
        data: {doc_id: $(this).data('docid')}
        success: (result) ->
          if result['status'] == 'true'
            Messenger().post
              message: result['message'],
              type: 'success',
              showCloseButton: true
          else
            Messenger().post
              message: result['message'],
              type: 'error',
              showCloseButton: true

      false

    true
 


	
	


