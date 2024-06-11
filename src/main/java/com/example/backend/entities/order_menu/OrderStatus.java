package com.example.backend.entities.order_menu;

public enum OrderStatus {

    Paid,  /** Displays that order is paid. It will be used for statistic porpuses*/
    ReadyToPay,   /** Displays that order is Ready To by paid. It will be used for statistic porpuses*/
    New,   /** Displays that order is New. This is happening after creating this order. It will be used for statistic porpuses*/
    In_Progress,   /** Displays that order is In Progress. It means that this staff is working on that order. It will be used for statistic porpuses*/
    Awaiting_For_Customer   /** Displays that order is already on the customers table. It will be used for statistic porpuses*/

}
