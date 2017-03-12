<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 11.03.2017
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Calculator</title>
</head>
<body>


<div id="app">
    <h2 align = "center">КАЛЬКУЛЯТОР РАСЧЕТА ПОДОХОДНОГО НАЛОГА
        С ФИЗИЧЕСКИХ ЛИЦ
        ЗА 2016 г.
        (для индивидуальных предпринимателей)
    </h2>
    <calculator style="margin: 0 auto; width: 800px"> </calculator>

</div>


<template id="calculator-template">
    <form>
        <p>
        Период, за который производится расчет:
        <select title="Квартал" id="scope" v-model="operation.period">
            <option selected="selected" value="3">Квартал</option>
            <option value="6">Полугодие</option>
            <option value="9">Девять месяцев</option>
            <option value="12">Год</option>
        </select><br />
        </p>
        <p>
        Сумма выручки от реализации товаров (работ, услуг),
        имущественных прав за выбранный период
        (без налога на добавленную стоимость), руб.
        <input type="number" step="any" v-model="operation.amount_receipts"><br />
        </p>
        <p>
        Сумма внереализационных доходов за выбранный период
        (без налога на добавленную стоимость), руб.
        <input type="number" step="any" v-model="operation.amount_income"><br />
        </p>
        <p>
        Наличие места основной работы:
        <input type="radio" v-model="operation.job_availability" value="1" @click="show=false"> да
        <input type="radio" v-model="operation.job_availability" value="0" @click="show=true"> нет<br />
        </p>

        <div v-show="show">
            <p>
                Наличие права на льготы (инвалид I или II группы, инвалид с детства,
                участник боевых действий на территории других государств и др.):
                <input type="radio" v-model="operation.benefits_availability" name="benefits_availability" value="1"> да
                <input type="radio" v-model="operation.benefits_availability" name="benefits_availability" value="0"> нет<br />
            </p>
            <p>
                Являетесь ли Вы вдовой (вдовцом),
                одиноким родителем, приемным родителем,
                опекуном или попечителем:
                <input type="radio" v-model="operation.lonely" name="lonely" value="1"> да
                <input type="radio" v-model="operation.lonely" name="lonely" value="0"> нет<br />
            </p>
            <p>
                Количество детей до 18 лет,
                из них количество детей-инвалидов
                <label>{{num_child}}</label>
                <input type="number" onkeypress="isNumberKey(event)" id="number_child" v-model="operation.number_child">
                <input type="number" value="{{operation.number_child_invalid}}" onkeypress="isNumberKey(event)" @keyup="check_child()" id="number_child_invalid" v-model="operation.number_child_invalid"><br />
            </p>
            <p>
                Количество иждивенцев
                <input type="number" onkeypress="isNumberKey(event)" v-model="operation.dependent"><br />
            </p>
            <p>
                Сумма расходов за выбранный период по страховым взносам по договорам добровольного страхования жизни и дополнительной пенсии, заключенным
                на срок не менее трех лет, а также по договорам добровольного
                страхования медицинских расходов, руб.
                <input type="number" step="any" v-model="operation.amount_contribution"><br />
            </p>
            <p>
                Сумма расходов за выбранный период на
                получение первого платного образования своего либо
                близких родственников, руб.
                <input type="number" step="any" v-model="operation.amount_education"><br />
            </p>
            <p>
                Сумма расходов за выбранный период на строительство либо приобретение жилья
                для нуждающихся в улучшении жилищных условий, руб.
                <input type="number" step="any" v-model="operation.amount_building"><br />
            </p>
        </div>

        <p>
        Сумма расходов за выбранный период, связанных с осуществлением
        предпринимательской деятельности, руб.
        <input type="number" step="any" v-model="operation.amount_entrepreneurial_activity"><br />
        </p>
        <div v-show="show_result">
                РЕЗУЛЬТАТ: <p>
                <h3 style="width: 90%">{{ operation.result }}</h3>
        </div>
        <div class="form-actions">
            <button type="button" @click="calculate">Рассчитать</button>
        </div>
    </form>
</template>


<script src="../../static/js/vue.js"></script>
<script src="../../static/js/vue-resource.min.js"></script>
<script>
    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which:event.keyCode;

        if(charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
        return true;

    }

</script>
<script>
    Vue.http.options.emulateJSON = true;

    Vue.component('calculator', {
        template: '#calculator-template',
        data:function(){
            return {
                operation:{},
                show: true,
                show_result: false
            };
        },
        methods: {
            calculate: function () {
                this.$http.post("/operation/new",this.operation).then(function(response) {
                    this.operation = response.data;
                    this.show_result = true;
                }, function(error){
                    alert('error ');
                });
            },
            check_child: function () {
                var number_child = document.getElementById("number_child").value;
                var number_child_invalid = document.getElementById("number_child_invalid").value;
                if (number_child_invalid > number_child) {
                    var n = parseInt(number_child_invalid.charAt(number_child_invalid.length - 1));
                    alert(n);
                    alert(number_child_invalid - n / 10);
                    this.operation.number_child_invalid = (number_child_invalid - n) / 10;
                }
            }

        }
    });

    new Vue({
       el: "#app",
        data: {  }
    });
</script>
</body>
</html>
