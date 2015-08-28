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
