import express,
    {
        Request,
        Response
    } from 'express';

import CARS_DATABASE from './../data/cars';

import Car from './../models/car';

export const ROUTER_CARS = express.Router();

ROUTER_CARS.get('/', (req: Request, res: Response) => {
    const cars = CARS_DATABASE;

    if(!cars) {
        res.status(404).json({ message: 'Cars not found.'}).send();
        return;
    }
    else {
        res.status(200).json(cars).send();
        return;
    }
})

ROUTER_CARS.get('/:id', (req: Request, res: Response) => {
    const car = CARS_DATABASE.find(car => car.id === Number(req.params.id));

    if (!car) {
        res.status(404).json({ message: 'Car not found.' }).send();
        return;
    } else {
        res.status(200).json(car).send();
        return;
    }
});

ROUTER_CARS.get('/:starts/:ending', (req: Request, res: Response) => {
    const arrange = CARS_DATABASE.slice(
        Number(req.params.starts),
        Number(req.params.ending)
    );

    if(arrange) {
        res.status(200).json(arrange).send();
        return;
    }
    else {
        res.status(404).json({ message: 'Can not get range of cars from database.' }).send();
        return;
    }
});

ROUTER_CARS.post('/', (req: Request, res: Response) => {
    const item = Car.create(req.body);

    if(item instanceof Car) {
        CARS_DATABASE.push(item);

        res.status(201).json({ message: 'Car added successfully.', item }).send();
        return;
    }
    else {
        res.status(404).json({ message: 'Car can not be created in the database.'}).send();
        return;
    }
});

ROUTER_CARS.put('/:id', (req: Request, res: Response) => {
    const index = CARS_DATABASE.findIndex(car => car.id === Number(req.params.id));

    if(index === -1) {
        res.status(404).json({ message: 'Car not found.' }).send();
        return;
    }
    else {
        const item = Car.create(req.body);

        console.log('Created item:', item);

        if(item instanceof Car) {
            console.log('Database before:', CARS_DATABASE);

            CARS_DATABASE[index].update(item);

            console.log('Updated database:', CARS_DATABASE);

            res.status(201).json({ message: 'Car updated successfully.', item }).send();
            return;
        } else {
            res.status(404).json({ message: 'Car can not be updated in the database.'}).send();
            return;
        }
    }
});

ROUTER_CARS.delete('/:id', (req: Request, res: Response) => {
    const index = CARS_DATABASE.findIndex(car => car.id === Number(req.params.id));

    if(index === -1) {
        res.status(404).json({ message: 'Car not found.' }).send();
        return;
    }
    else {
        const answer = CARS_DATABASE[index].delete();

        if(answer) {
            res.status(204).json({ message: 'Car removed successfully.' }).send();
            return;
        }
        else {
            res.status(404).json({ message: 'Can not delete car from database.' }).send();
            return;
        }
    }
});