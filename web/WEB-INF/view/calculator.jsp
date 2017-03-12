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
    <link rel="stylesheet" type="text/css" href="../../static/css/calculator_style.css"/>
</head>
<body>


<div id="app">

    <calculator style=" width: 800px">

    </calculator>

</div>


<template id="calculator-template">
    <form>
        <h2 align = "center">КАЛЬКУЛЯТОР РАСЧЕТА ПОДОХОДНОГО НАЛОГА
            С ФИЗИЧЕСКИХ ЛИЦ
            ЗА 2016 г.
            (для индивидуальных предпринимателей)
        </h2>
        <div>
        <label>Период, за который производится расчет:</label>
        <select value="{{operation.period}}" title="Квартал" id="scope" v-model="operation.period">
            <option selected="selected" value="3">Квартал</option>
            <option value="6">Полугодие</option>
            <option value="9">Девять месяцев</option>
            <option value="12">Год</option>
        </select>
        </div>
        <div>
            <label>
                Сумма выручки от реализации товаров (работ, услуг),
                имущественных прав за выбранный период
                (без налога на добавленную стоимость), руб.
            </label>
            <input value="{{operation.amount_receipts}}" type="number" step="any" v-model="operation.amount_receipts">
        </div>
        <div>
            <label>
                Сумма внереализационных доходов за выбранный период
                (без налога на добавленную стоимость), руб.
            </label>
            <input value="{{operation.amount_income}}" type="number" step="any" v-model="operation.amount_income">
        </div>
        <div>
            <label>Наличие места основной работы:</label>
            <ul>
                <li>
                    <label>
                        <input type="radio" v-model="operation.job_availability" value="1" @click="show=false">да
                    </label>
                </li>
                <li>
                    <label>
                        <input type="radio" v-model="operation.job_availability" value="0" @click="show=true">нет
                    </label>
                </li>
            </ul>
        </div>

        <div v-show="show">
            <div>
                <label>Наличие права на льготы (инвалид I или II группы, инвалид с детства,
                участник боевых действий на территории других государств и др.):
                </label>
                <ul>
                    <li>
                        <label>
                            <input type="radio" v-model="operation.benefits_availability" name="benefits_availability" value="1">да
                        </label>
                    </li>
                    <li>
                        <label>
                            <input type="radio" v-model="operation.benefits_availability" name="benefits_availability" value="0">нет
                        </label>
                    </li>
                </ul>

            </div>
            <div>
                <label>Являетесь ли Вы вдовой (вдовцом),
                одиноким родителем, приемным родителем,
                опекуном или попечителем:</label>
                <ul>
                    <li>
                        <label>
                            <input type="radio" v-model="operation.lonely" name="lonely" value="1">да
                        </label>
                    </li>
                    <li>
                        <label>
                            <input type="radio" v-model="operation.lonely" name="lonely" value="0">нет
                        </label>
                    </li>
                </ul>
            </div>
            <div>
                <label>Количество детей до 18 лет,
                из них количество детей-инвалидов</label>
                <input type="number" value="0" onkeypress="isNumberKey(event)" id="number_child" v-model="operation.number_child">
                <input type="number" value="{{operation.number_child_invalid}}" onkeypress="isNumberKey(event)" @keyup="check_child()" id="number_child_invalid" v-model="operation.number_child_invalid">

            </div>
            <div>
                <label>Количество иждивенцев</label>
                <input type="number" onkeypress="isNumberKey(event)" v-model="operation.dependent">
            </div>
            <div>
                <label>Сумма расходов за выбранный период по страховым взносам по договорам добровольного страхования жизни и дополнительной пенсии, заключенным
                на срок не менее трех лет, а также по договорам добровольного
                страхования медицинских расходов, руб.</label>
                <input type="number" value="0" step="any" v-model="operation.amount_contribution">
            </div>
            <div>
                <label>Сумма расходов за выбранный период на
                получение первого платного образования своего либо
                близких родственников, руб.</label>
                <input type="number" value="0" step="any" v-model="operation.amount_education">
            </div>
            <div>
                <label>Сумма расходов за выбранный период на строительство либо приобретение жилья
                для нуждающихся в улучшении жилищных условий, руб.</label>
                <input type="number" value="0" step="any" v-model="operation.amount_building"><br />
            </div>
        </div>

        <div>
        <label>Сумма расходов за выбранный период, связанных с осуществлением
        предпринимательской деятельности,</label>
        <input type="number" value="0" step="any" v-model="operation.amount_entrepreneurial_activity"><br />
        </div>
        <div v-show="show_result">
                РЕЗУЛЬТАТ: <p>
                <h3 style="width: 90%">{{ operation.result }}</h3>
        </div>
        <div>
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
                operation:{
                    period:3,
                    amount_receipts:0,
                    amount_income:0,
                    job_availability:0,
                    benefits_availability:1,
                    lonely: 0,
                    number_child: 0,
                    number_child_invalid: 0,
                    dependent: 0,
                    amount_contribution: 0,
                    amount_education:0,
                    amount_building:0,
                    amount_entrepreneurial_activity: 0
                },
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
