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

<body align="center">
<script src="../../static/js/vue.js"></script>
<script src="../../static/js/vue-resource.min.js"></script>
<script src="../../static/js/vue-router.js"></script>

<div id="app">

    <router-view></router-view>

</div>

<script type="vue/template" id="calculatorTemplate" style="text-align: left; width: 800px">
    <form>
        <h2 align="center">КАЛЬКУЛЯТОР РАСЧЕТА ПОДОХОДНОГО НАЛОГА
            С ФИЗИЧЕСКИХ ЛИЦ
            ЗА 2016 г.
            (для индивидуальных предпринимателей)
        </h2>
        <div style="text-align: left">
            <label>Период, за который производится расчет:</label>
            <select title="Квартал" id="scope" v-model="operation.period">
                <option value="3">Квартал</option>
                <option value="6">Полугодие</option>
                <option value="9">Девять месяцев</option>
                <option value="12">Год</option>
            </select>
        </div>
        <div style="text-align: left">
            <label>
                Сумма выручки от реализации товаров (работ, услуг),
                имущественных прав за выбранный период
                (без налога на добавленную стоимость), руб.
            </label>
            <input type="number" step="any" v-model="operation.amount_receipts">
        </div>
        <div style="text-align: left">
            <label>
                Сумма внереализационных доходов за выбранный период
                (без налога на добавленную стоимость), руб.
            </label>
            <input type="number" step="any" v-model="operation.amount_income">
        </div>
        <div style="text-align: left">
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

        <div v-show="show" style="text-align: left">
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
            <div style="text-align: left">
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
            <div style="text-align: left">
                <label>Количество детей до 18 лет,
                    из них количество детей-инвалидов</label>
                <input type="number" onkeypress="isNumberKey(event)" id="number_child" v-model="operation.number_child">
                <input type="number" onkeypress="isNumberKey(event)" @keyup="check_child()" id="number_child_invalid" v-model="operation.number_child_invalid">

            </div>
            <div style="text-align: left">
                <label>Количество иждивенцев</label>
                <input type="number" onkeypress="isNumberKey(event)" v-model="operation.number_dependent">
            </div>
            <div style="text-align: left">
                <label>Сумма расходов за выбранный период по страховым взносам по договорам добровольного страхования жизни и дополнительной пенсии, заключенным
                    на срок не менее трех лет, а также по договорам добровольного
                    страхования медицинских расходов, руб.</label>
                <input type="number" step="any" v-model="operation.amount_contribution">
            </div>
            <div style="text-align: left">
                <label>Сумма расходов за выбранный период на
                    получение первого платного образования своего либо
                    близких родственников, руб.</label>
                <input type="number" step="any" v-model="operation.amount_education">
            </div>
            <div style="text-align: left">
                <label>Сумма расходов за выбранный период на строительство либо приобретение жилья
                    для нуждающихся в улучшении жилищных условий, руб.</label>
                <input type="number" step="any" v-model="operation.amount_building"><br />
            </div>
        </div>

        <div style="text-align: left">
            <label>Сумма расходов за выбранный период, связанных с осуществлением
                предпринимательской деятельности, руб.</label>
            <input type="number" step="any" v-model="operation.amount_entrepreneurial_activity"><br />
        </div>
        <div style="text-align: left" v-show="show_result">

            <label><h3>РЕЗУЛЬТАТ:</h3></label>
            <h3 style="width: 90%">{{ operation.result }}</h3>
        </div>
        <div style="text-align: left">
            <label><button type="button" @click="all_operations">Все операции</button></label>
            <button type="button" @click="calculate">Рассчитать</button>
        </div>
    </form>
</script>

<script type="vue/template" id="operationsTemplate" style="text-align: left; width: 800px">
    <form>
        <h2 align="center">Операции
        </h2>
        <ul>
            <li v-for="user in orderedUsers">
                {{user.name}}, {{user.age}}
            </li>
        </ul>
        <table>
            <thead>
            <tr>
                <th>
                    Период
                </th>
                <th>
                    Выручка от реализации товаров (работ, услуг), руб.
                </th>
                <th>
                    Внереализационные доходы, руб.
                </th>
                <th>
                    Основная работа
                </th>
                <th>
                    Право на льготы
                </th>
                <th>
                    Вдова(вдовец),
                    одинокий родитель,приемный родитель,
                    опекун/попечитель
                </th>
                <th>
                    Количество детей до 18 лет/детей-инвалидов
                </th>
                <th>
                    Количество иждивенцев
                </th>
                <th>
                    Расходы по страховым взносам, руб
                </th>
                <th>
                    Расходы на получение первого платного образования, руб.
                </th>
                <th>
                    Расходы на строительство/приобретение жилья, руб
                </th>
                <th>
                    Расходы, связанных с предпринимательской деятельностью, руб
                </th>
                <th>
                    Результат
                </th>
            </tr>
            <tr>
                <th>
                    <input type="text" id="find_by_period" value="{{find_by_period+period}}" v-model="find_by_period"/>
                </th>
                <th>

                </th>
                <th>

                </th>
                <th>

                </th>
                <th>

                </th>
                <th>

                </th>
                <th>

                </th>
                <th>

                </th>
                <th>

                </th>
                <th>

                </th>
                <th>

                </th>
                <th>

                </th>
                <th>

                </th>
            </tr>
            </thead>
            <tbody>
            <!--<template v-for="operation in operations | filterBy find_by_period in 'period'">-->
                <template v-for="operation in filterOperations">
                <tr>
                    <td v-if=" operation.period == 3">
                        Квартал
                    </td>
                    <td v-if="operation.period == 6">
                        Полугодие
                    </td>
                    <td v-if="operation.period == 9">
                        Девять месяцев
                    </td>
                    <td v-if="operation.period == 12">
                        Год
                    </td>
                    <td>{{ operation.amount_receipts }}</td>
                    <td>{{ operation.amount_income }}</td>
                    <td v-if="operation.job_availability == 1">
                        да
                    </td>
                    <td v-if="operation.job_availability == 0">
                        нет
                    </td>
                    <td v-if="operation.benefits_availability == 1">
                        да
                    </td>
                    <td v-if="operation.benefits_availability == 0">
                        нет
                    </td>
                    <td v-if="operation.lonely == 1">
                        да
                    </td>
                    <td v-if="operation.lonely == 0">
                        нет
                    </td>
                    <td>{{ operation.number_child }}/{{ operation.number_child_invalid }}</td>
                    <td>{{ operation.number_dependent }}</td>
                    <td>{{ operation.amount_contribution }}</td>
                    <td>{{ operation.amount_education}}</td>
                    <td>{{ operation.amount_building }}</td>
                    <td>{{ operation.amount_entrepreneurial_activity }}</td>
                    <td>{{ operation.result }}</td>
                </tr>
            </template>
            </tbody>
        </table>
    </form>
</script>

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
    Vue.use(VueRouter);
    Vue.use(VueResource);

    var Operation = Vue.extend({
        template:'#operationsTemplate',
        data:function() {
            this.$http.get("/operation").then(function(response){
                this.operations = response.data;
            });

            return{
                operations:{},
                find_by_period:'',
                array: [
                    {
                        name: 'Иван',
                        age: 45
                    },
                    {
                        name: 'Алиса',
                        age: 322
                    },
                    {
                      name: 'Вася',
                      age: 42
                    }
                ]


            }
        },
        computed:{
          filterOperations: function(){
              if(this.find_by_period) {
                  return this.operations.filter(function (operation) {

                      this.find_by_period = document.getElementById("find_by_period").value;

                      if(operation.period == 3 && "квартал".indexOf(this.find_by_period.toLowerCase()) != -1)
                          return true;
                      else if(operation.period == 6 && "полугодие".indexOf(this.find_by_period.toLowerCase()) != -1)
                          return true;
                      else if(operation.period == 9 && "двенадцать месяцев".toLowerCase().indexOf(this.find_by_period.toLowerCase()) != -1)
                          return true;
                      else if(operation.period == 12 && "год".indexOf(this.find_by_period.toLowerCase()) != -1)
                          return true;
                      else return false;

                  })
              } else
                  return this.operations;
          }
        }
    });

    var Calculator = Vue.extend({
        template:'#calculatorTemplate',
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
                    number_dependent: 0,
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
            },
            all_operations: function () {
                this.$router.push("/operation");
            }

        }
    });

    var router = new VueRouter({
        routes:[
            { path: '/', component: Calculator },
            { path: '/operation', component: Operation }
        ]
    });

    var app = new Vue({
        data: {find_by_period: "a"},
        router: router
    }).$mount('#app');
</script>


</body>
</html>
