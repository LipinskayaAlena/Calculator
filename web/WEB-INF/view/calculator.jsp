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
        <select v-model="operation.period">
            <option label="Квартал" value="3">Квартал</option>
            <option value="6">Полугодие</option>
            <option value="9">Девять месяцев</option>
            <option value="12">Год</option>
        </select><br />
        </p>
        <p>
        Сумма выручки от реализации товаров (работ, услуг),
        имущественных прав за выбранный период
        (без налога на добавленную стоимость), руб.
        <input type="text" v-model="operation.amount_receipts"><br />
        </p>
        <p>
        Сумма внереализационных доходов за выбранный период
        (без налога на добавленную стоимость), руб.
        <input type="text" v-model="operation.amount_income"><br />
        </p>
        <p>
        Наличие места основной работы:
        <input type="radio" v-model="operation.job_availability" value="1"> да
        <input type="radio" v-model="operation.job_availability" value="0"> нет<br />
        </p>
        <p>
        Наличие права на льготы (инвалид I или II группы, инвалид с детства,
        участник боевых действий на территории других государств и др.):
        <input type="radio" v-model="operation.benefits_availability" value="1"> да
        <input type="radio" v-model="operation.benefits_availability" value="0"> нет<br />
        </p>
        <p>
        Являетесь ли Вы вдовой (вдовцом),
        одиноким родителем, приемным родителем,
        опекуном или попечителем:
        <input type="radio" v-model="operation.lonely" value="1"> да
        <input type="radio" v-model="operation.lonely" value="0"> нет<br />
        </p>
        <p>
        Количество детей до 18 лет,
        из них количество детей-инвалидов
        <input type="number" v-model="operation.number_child">
        <input type="number" v-model="operation.number_child_invalid"><br />
        </p>
        <p>
        Количество иждивенцев
        <input type="number" v-model="operation.dependent"><br />
        </p>
        <p>
        Сумма расходов за выбранный период по страховым взносам по договорам добровольного страхования жизни и дополнительной пенсии, заключенным
        на срок не менее трех лет, а также по договорам добровольного
        страхования медицинских расходов, руб.
        <input type="text" v-model="operation.amount_contribution"><br />
        </p>
        <p>
        Сумма расходов за выбранный период на
        получение первого платного образования своего либо
        близких родственников, руб.
        <input type="text" v-model="operation.amount_education"><br />
        </p>
        <p>
        Сумма расходов за выбранный период на строительство либо приобретение жилья
        для нуждающихся в улучшении жилищных условий, руб.
        <input type="text" v-model="operation.amount_building"><br />
        </p>
        <p>
        Сумма расходов за выбранный период, связанных с осуществлением
        предпринимательской деятельности, руб.
        <input type="text" v-model="operation.amount_entrepreneurial_activity"><br />
        </p>
        <p>
        Результат
        <textarea v-model="operation.result" style="height: 50px;width: 90%"></textarea>
        </p>
        <div class="form-actions">
            <button type="button" v-on:click="calculate">Calculate</button>
        </div>
    </form>
</template>


<script src="../../static/js/vue.js"></script>
<script src="../../static/js/vue-resource.min.js"></script>
<script>
    Vue.http.options.emulateJSON = true;

    Vue.component('calculator', {
        template: '#calculator-template',
        data:function(){
            return {
                operation:{}
            };
        },
        methods: {
            calculate: function () {
                alert('culc ');
                this.$http.post("/operation/new",this.operation).then(function(response) {
                    alert('success ');
                }, function(error){
                    alert('error ');
                });
            }
        }
    });

    new Vue({
       el: "#app",
        data: {message:"Hello world"}


    });
</script>
</body>
</html>
