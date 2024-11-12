import express,
    {
        Request,
        Response
    } from 'express';

import CARS_DATABASE from './../data/cars';

export const ROUTER_FAVORITES = express.Router();

ROUTER_FAVORITES.get('/', (req: Request, res: Response) => {
    const favorites = CARS_DATABASE.filter(car => car.isFavorite);

    if(favorites) {
        res.status(200).json(favorites).send();
        return;
    } else {
        res.status(404).json({ message: 'Can not find favorites cars.' }).send();
        return;
    }
});

ROUTER_FAVORITES.put('/:id', (req: Request, res: Response) => {
    const index = CARS_DATABASE.findIndex(car => car.id === Number(req.params.id));

    if (index === -1) {
        res.status(404).json({ message: 'Car not found.' }).send();
        return;
    } else {
        CARS_DATABASE[index].updateFavorite(undefined);

        res.status(200).json({ message: 'Car was updated in favorites.' }).send();
        return;
    }
});