___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Day of the Week",
  "description": "Returns the current Day of the Week in multiple formats (e.g., Monday, Mon, 1). Includes Timezone Offset to match specific business hours regardless of user location. Default day is UTC based.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "param_style",
    "displayName": "Day format",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "style_1",
        "displayValue": "Short Name (Mon)"
      },
      {
        "value": "style_2",
        "displayValue": "Long Name (Monday)"
      },
      {
        "value": "style_3",
        "displayValue": "Number ISO (Mon\u003d1)"
      },
      {
        "value": "style_4",
        "displayValue": "Number US (Sun\u003d1)"
      }
    ],
    "simpleValueType": true,
    "help": "Select one of the options from the drop-down menu for the preferred Day output. Day output is based on UTC."
  },
  {
    "type": "TEXT",
    "name": "param_offset",
    "displayName": "Timezone Offset (Hours)",
    "simpleValueType": true,
    "help": "Enter -5 for New York, +1 for Paris, etc. Leave 0 for UTC.",
    "defaultValue": 0
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

var getTimestampMillis = require('getTimestampMillis');

// 1. Get UTC time
var v_now = getTimestampMillis();

// 2. Get User Offset (Default to 0 if empty)
// We multiply by 1 to force it to be a number
var v_offsetHours = (data.param_offset || 0) * 1;

// 3. Apply Offset (Hours * 60 mins * 60 secs * 1000 ms)
var v_offsetMillis = v_offsetHours * 3600000;
var v_adjustedTime = v_now + v_offsetMillis;

// 4. Calculate Day Index (Using the Adjusted Time)
// Bitwise hack to remove decimals (Math.floor replacement)
var v_daysSinceEpoch = (v_adjustedTime / 86400000) | 0;
var v_dayIndex = (v_daysSinceEpoch + 4) % 7;

// 5. Define Arrays
var v_arrShort = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
var v_arrLong = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

// 6. Get User Selection
var v_choice = data.param_style;
var v_result;

if (v_choice === 'style_1') {
  v_result = v_arrShort[v_dayIndex];
} 
else if (v_choice === 'style_2') {
  v_result = v_arrLong[v_dayIndex];
} 
else if (v_choice === 'style_3') {
  // ISO: Mon=1 ... Sun=7
  v_result = (v_dayIndex === 0) ? 7 : v_dayIndex;
} 
else if (v_choice === 'style_4') {
  // US: Sun=1 ... Sat=7
  v_result = v_dayIndex + 1;
} 
else {
  v_result = v_arrShort[v_dayIndex];
}

return v_result;


___TESTS___

scenarios:
- name: Untitled test 1
  code: |-
    var mockData = {
      param_style: 'style_2',
      param_offset: 0  // Test with 0 offset
    };

    // Mock timestamp for Tuesday Nov 18 2025
    mock('getTimestampMillis', function() {
      return 1763460000000;
    });

    var result = runCode(mockData);

    assertThat(result).isEqualTo('Tuesday');


___NOTES___

Created on 11/18/2025, 2:57:52 PM


