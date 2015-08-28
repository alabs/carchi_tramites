#
#
# http://snipplr.com/view/26338/cascading-select-boxes/

cascadeSelect = (parent, child) ->
  childOptions = child.find('option:not(.static)')
  child.data 'options', childOptions
  parent.change ->
    childOptions.remove()
    child.append(child.data('options').filter('.sub_' + @value)).change()
  childOptions.not('.static, .sub_' + parent.val()).remove()

$ ->
  cascadeForm = $('.formtastic')
  provSelect = cascadeForm.find('#inscription_provincia')
  cantonSelect = cascadeForm.find('#inscription_canton')
  parroquiaSelect = cascadeForm.find('#inscription_parroquia')
  repprovSelect = cascadeForm.find('#inscription_rep_provincia')
  repcantonSelect = cascadeForm.find('#inscription_rep_canton')
  repparroquiaSelect = cascadeForm.find('#inscription_rep_parroquia')

  cascadeSelect provSelect, cantonSelect
  cascadeSelect cantonSelect, parroquiaSelect
  cascadeSelect repprovSelect, repcantonSelect
  cascadeSelect repcantonSelect, repparroquiaSelect

  if $('#inscription_provincia').val() == ""
    $('#inscription_provincia').find('option').removeAttr('selected')
    $('#inscription_provincia').find('option[value="c_insprovincia_4"]').prop("selected", true)
    $('#inscription_provincia').change()

    $('#inscription_canton').find('option').removeAttr('selected')
    $('#inscription_canton').find('option[value="c_inscanton_4_1"]').prop("selected", true)
    $('#inscription_canton').change()

    $('#inscription_parroquia').find('option').removeAttr('selected')
    $('#inscription_parroquia').find('option[value="c_insparroquia_4_1_50"]').prop("selected", true)
