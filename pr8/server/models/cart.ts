import CARS_DATABASE from "../data/cars";
import CART_DATABASE from "../data/cart";
import Car from "./car"

export default class Cart {
    car: Car;
    quantity: number;

    constructor(_car: Car, _quantity: 0) {
        this.car = _car;
        this.quantity = _quantity;
    }

    increase(): void {
        this.quantity++;
    }

    decrease(): void {
        if(this.quantity === 1)
            return;
        else
            this.quantity--;
    }

    delete(): void | undefined {
        if(CART_DATABASE.includes(this))
            CART_DATABASE.splice(CART_DATABASE.findIndex(cart => cart.car.id === this.car.id), 1);
        else
            return undefined;
    }

    static create(obj: any): Cart {
        return new Cart(CARS_DATABASE.find(car => car.id === Number(obj.car.id))!, obj.quantity);
    }
}