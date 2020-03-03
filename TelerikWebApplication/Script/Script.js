(function (global, undefined) {
    var demo = {};

    function populateValue() {
        $get(demo.label).innerHTML = $get(demo.textBox).value;
        //the RadWindow's content template is an INaming container and the server code block is needed
        $find(demo.contentTemplateID).close();
    }

    function openWinContentTemplate() {
        $find(demo.templateWindowID).show();
    }
    function openWinNavigateUrl() {
        $find(demo.urlWindowID).show();
    }

    global.$windowContentDemo = demo;
    global.populateValue = populateValue;
    global.openWinContentTemplate = openWinContentTemplate;
    global.openWinNavigateUrl = openWinNavigateUrl;
})(window);