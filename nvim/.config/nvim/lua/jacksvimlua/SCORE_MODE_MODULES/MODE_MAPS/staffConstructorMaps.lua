return {
  ['w'] = 'bn',
  ['h'] = 'norm h',
  ['j'] = 'norm j',
  ['k'] = 'norm k',
  ['l'] = 'norm l',

  -- single staff opening
  ['sso'] = ":lua staff_builder_func('SC_sO_1')",

  -- single staff continuing
  ['ssc'] = ":lua staff_builder_func('SC_sC_2')",

  -- double staff opening
  ['dso'] = ":lua staff_builder_func('SC_dO_3')",

  -- double staff continuing
  ['dsc'] = ":lua staff_builder_func('SC_dC_4')",

  ['q'] = ':lua exit_SC()',
}

