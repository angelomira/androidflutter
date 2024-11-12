import PROFILE_DATABASE from '../data/profile';
import express,
    {
        Request,
        Response
    } from 'express';
import Profile from '../models/profile';

export const ROUTER_PROFILES = express.Router();

ROUTER_PROFILES.get('/', (req: Request, res: Response) => {
    const profiles = PROFILE_DATABASE;

    if(profiles) {
        res.status(200).json(profiles).send();
        return;
    } else {
        res.status(404).json({ message: 'Can not find profiles.' }).send();
        return;
    }
});

ROUTER_PROFILES.get('/:id', (req: Request, res: Response) => {
    const profile = PROFILE_DATABASE.find(profile => profile.id === Number(req.params.id));

    if(!profile) {
        res.status(404).json({ message: 'Profile not found.' }).send();
        return;
    } else {
        res.status(200).json(profile).send();
        return;
    }
});

ROUTER_PROFILES.post('/', (req: Request, res: Response) => {
    const item = Profile.create(req.body);

    if(item instanceof Profile) {
        PROFILE_DATABASE.push(item);

        res.status(201).json({ message: 'Profile added successfully.', item }).send();
        return;
    }
    else {
        res.status(404).json({ message: 'Profile can not be created in the database.'}).send();
        return;
    }
});

ROUTER_PROFILES.put('/:id', (req: Request, res: Response) => {
    const index = PROFILE_DATABASE.findIndex(car => car.id === Number(req.params.id));

    if(index === -1) {
        res.status(404).json({ message: 'Profile not found.' }).send();
        return;
    }
    else {
        const item = Profile.create(req.body);

        console.log('Created item:', item);

        if(item instanceof Profile) {
            PROFILE_DATABASE[index].update(item);

            res.status(201).json({ message: 'Profile updated successfully.', item }).send();
            return;
        } else {
            res.status(404).json({ message: 'Profile can not be updated in the database.'}).send();
            return;
        }
    }
});

ROUTER_PROFILES.delete('/:id', (req: Request, res: Response) => {
    const index = PROFILE_DATABASE.findIndex(profile => profile.id === Number(req.params.id));

    if(index === -1) {
        res.status(404).json({ message: 'Profile not found.' }).send();
        return;
    }
    else {
        const answer = PROFILE_DATABASE[index].delete();

        if(answer) {
            res.status(204).json({ message: 'Profile removed successfully.' }).send();
            return;
        }
        else {
            res.status(404).json({ message: 'Profile not delete car from database.' }).send();
            return;
        }
    }
});