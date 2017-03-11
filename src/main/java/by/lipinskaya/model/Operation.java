package by.lipinskaya.model;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Asus on 10.03.2017.
 */
@Entity
@Table(name="operation")
public class Operation implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id_operation;

    @Column(name = "period", nullable = false)
    private int period;

    @Column(name = "amount_receipts")
    private float amount_receipts;

    @Column(name = "amount_income")
    private float amount_income;

    @Column(name = "job_availability")
    private int job_availability;

    @Column(name = "benefits_availability")
    private int benefits_availability;

    @Column(name = "lonely")
    private int lonely;

    @Column(name = "number_child")
    private int number_child;

    @Column(name = "number_child_invalid")
    private int number_child_invalid;

    @Column(name = "number_dependent")
    private int number_dependent;

    @Column(name = "amount_contribution")
    private float amount_contribution;

    @Column(name = "amount_education")
    private float amount_education;

    @Column(name = "amount_building")
    private float amount_building;

    @Column(name = "amount_entrepreneurial_activity")
    private float amount_entrepreneurial_activity;

    @Column(name = "result")
    private float result;

    public long getId_operation() {
        return id_operation;
    }

    public void setId_operation(long id_operation) {
        this.id_operation = id_operation;
    }

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
    }

    public float getAmount_receipts() {
        return amount_receipts;
    }

    public void setAmount_receipts(float amount_receipts) {
        this.amount_receipts = amount_receipts;
    }

    public float getAmount_income() {
        return amount_income;
    }

    public void setAmount_income(float amount_income) {
        this.amount_income = amount_income;
    }

    public int getJob_availability() {
        return job_availability;
    }

    public void setJob_availability(int job_availability) {
        this.job_availability = job_availability;
    }

    public int getBenefits_availability() {
        return benefits_availability;
    }

    public void setBenefits_availability(int benefits_availability) {
        this.benefits_availability = benefits_availability;
    }

    public int getLonely() {
        return lonely;
    }

    public void setLonely(int lonely) {
        this.lonely = lonely;
    }

    public int getNumber_child() {
        return number_child;
    }

    public void setNumber_child(int number_child) {
        this.number_child = number_child;
    }

    public int getNumber_child_invalid() {
        return number_child_invalid;
    }

    public void setNumber_child_invalid(int number_child_invalid) {
        this.number_child_invalid = number_child_invalid;
    }

    public int getNumber_dependent() {
        return number_dependent;
    }

    public void setNumber_dependent(int number_dependent) {
        this.number_dependent = number_dependent;
    }

    public float getAmount_contribution() {
        return amount_contribution;
    }

    public void setAmount_contribution(float amount_contribution) {
        this.amount_contribution = amount_contribution;
    }

    public float getAmount_education() {
        return amount_education;
    }

    public void setAmount_education(float amount_education) {
        this.amount_education = amount_education;
    }

    public float getAmount_building() {
        return amount_building;
    }

    public void setAmount_building(float amount_building) {
        this.amount_building = amount_building;
    }

    public float getAmount_entrepreneurial_activity() {
        return amount_entrepreneurial_activity;
    }

    public void setAmount_entrepreneurial_activity(float amount_entrepreneurial_activity) {
        this.amount_entrepreneurial_activity = amount_entrepreneurial_activity;
    }

    public float getResult() {
        return result;
    }

    public void setResult(float result) {
        this.result = result;
    }

}
