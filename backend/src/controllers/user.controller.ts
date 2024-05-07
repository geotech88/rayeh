import { Response } from "express";
import { ExtendedRequest } from "../middlewares/Authentication";
import { AppDataSource } from "../config/ormconfig";
import { encrypt, getToken } from "../helpers/helpers";
import { User } from "../entity/Users.entity";
import { Not } from "typeorm";
import axios from "axios";

export class UserController {
    static async getAllUsers(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const users = await UserRepository.find();
            return res.status(200).json({data: users});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async getMyInfo(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {email: req.user?.email}});
            return res.status(200).json({data: user});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async getUser(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.find({where: {auth0UserId: req.params.id}});
            return res.status(200).json({data: user});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    //TODO: Still an issue with the auth0 update patch request: To fix
    static async updateUserInfo(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {email: req.user?.email}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            if (req.body?.email) {
                const checkMail = await UserRepository.findOne({where: {email: req.body?.email, id: Not(user.id)}});
                if (checkMail) {
                    return res.status(400).json({message: "Email already in use"});
                }
            }
            user.name = req.body.name;
            user.email = req.body.email;
            user.path = req.body.path;
            await UserRepository.save(user);
            // let token = await getToken();
            let token= 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ2a3poSGphanFMNWU1OTZGTVlRYiJ9.eyJpc3MiOiJodHRwczovL2Rldi12cXhzZ2ZhbG50Mmg0ZG5hLnVzLmF1dGgwLmNvbS8iLCJzdWIiOiJqUjVQY0Z6M1paRzBEYmdNczNXME9Td1dDZXo2aHc4OUBjbGllbnRzIiwiYXVkIjoiaHR0cHM6Ly9kZXYtdnF4c2dmYWxudDJoNGRuYS51cy5hdXRoMC5jb20vYXBpL3YyLyIsImlhdCI6MTcxNTAyOTg0OCwiZXhwIjoxNzE1MTE2MjQ4LCJzY29wZSI6InJlYWQ6Y2xpZW50X2dyYW50cyBjcmVhdGU6Y2xpZW50X2dyYW50cyBkZWxldGU6Y2xpZW50X2dyYW50cyB1cGRhdGU6Y2xpZW50X2dyYW50cyByZWFkOnVzZXJzIHVwZGF0ZTp1c2VycyBkZWxldGU6dXNlcnMgY3JlYXRlOnVzZXJzIHJlYWQ6dXNlcnNfYXBwX21ldGFkYXRhIHVwZGF0ZTp1c2Vyc19hcHBfbWV0YWRhdGEgZGVsZXRlOnVzZXJzX2FwcF9tZXRhZGF0YSBjcmVhdGU6dXNlcnNfYXBwX21ldGFkYXRhIHJlYWQ6dXNlcl9jdXN0b21fYmxvY2tzIGNyZWF0ZTp1c2VyX2N1c3RvbV9ibG9ja3MgZGVsZXRlOnVzZXJfY3VzdG9tX2Jsb2NrcyBjcmVhdGU6dXNlcl90aWNrZXRzIHJlYWQ6Y2xpZW50cyB1cGRhdGU6Y2xpZW50cyBkZWxldGU6Y2xpZW50cyBjcmVhdGU6Y2xpZW50cyByZWFkOmNsaWVudF9rZXlzIHVwZGF0ZTpjbGllbnRfa2V5cyBkZWxldGU6Y2xpZW50X2tleXMgY3JlYXRlOmNsaWVudF9rZXlzIHJlYWQ6Y29ubmVjdGlvbnMgdXBkYXRlOmNvbm5lY3Rpb25zIGRlbGV0ZTpjb25uZWN0aW9ucyBjcmVhdGU6Y29ubmVjdGlvbnMgcmVhZDpyZXNvdXJjZV9zZXJ2ZXJzIHVwZGF0ZTpyZXNvdXJjZV9zZXJ2ZXJzIGRlbGV0ZTpyZXNvdXJjZV9zZXJ2ZXJzIGNyZWF0ZTpyZXNvdXJjZV9zZXJ2ZXJzIHJlYWQ6ZGV2aWNlX2NyZWRlbnRpYWxzIHVwZGF0ZTpkZXZpY2VfY3JlZGVudGlhbHMgZGVsZXRlOmRldmljZV9jcmVkZW50aWFscyBjcmVhdGU6ZGV2aWNlX2NyZWRlbnRpYWxzIHJlYWQ6cnVsZXMgdXBkYXRlOnJ1bGVzIGRlbGV0ZTpydWxlcyBjcmVhdGU6cnVsZXMgcmVhZDpydWxlc19jb25maWdzIHVwZGF0ZTpydWxlc19jb25maWdzIGRlbGV0ZTpydWxlc19jb25maWdzIHJlYWQ6aG9va3MgdXBkYXRlOmhvb2tzIGRlbGV0ZTpob29rcyBjcmVhdGU6aG9va3MgcmVhZDphY3Rpb25zIHVwZGF0ZTphY3Rpb25zIGRlbGV0ZTphY3Rpb25zIGNyZWF0ZTphY3Rpb25zIHJlYWQ6ZW1haWxfcHJvdmlkZXIgdXBkYXRlOmVtYWlsX3Byb3ZpZGVyIGRlbGV0ZTplbWFpbF9wcm92aWRlciBjcmVhdGU6ZW1haWxfcHJvdmlkZXIgYmxhY2tsaXN0OnRva2VucyByZWFkOnN0YXRzIHJlYWQ6aW5zaWdodHMgcmVhZDp0ZW5hbnRfc2V0dGluZ3MgdXBkYXRlOnRlbmFudF9zZXR0aW5ncyByZWFkOmxvZ3MgcmVhZDpsb2dzX3VzZXJzIHJlYWQ6c2hpZWxkcyBjcmVhdGU6c2hpZWxkcyB1cGRhdGU6c2hpZWxkcyBkZWxldGU6c2hpZWxkcyByZWFkOmFub21hbHlfYmxvY2tzIGRlbGV0ZTphbm9tYWx5X2Jsb2NrcyB1cGRhdGU6dHJpZ2dlcnMgcmVhZDp0cmlnZ2VycyByZWFkOmdyYW50cyBkZWxldGU6Z3JhbnRzIHJlYWQ6Z3VhcmRpYW5fZmFjdG9ycyB1cGRhdGU6Z3VhcmRpYW5fZmFjdG9ycyByZWFkOmd1YXJkaWFuX2Vucm9sbG1lbnRzIGRlbGV0ZTpndWFyZGlhbl9lbnJvbGxtZW50cyBjcmVhdGU6Z3VhcmRpYW5fZW5yb2xsbWVudF90aWNrZXRzIHJlYWQ6dXNlcl9pZHBfdG9rZW5zIGNyZWF0ZTpwYXNzd29yZHNfY2hlY2tpbmdfam9iIGRlbGV0ZTpwYXNzd29yZHNfY2hlY2tpbmdfam9iIHJlYWQ6Y3VzdG9tX2RvbWFpbnMgZGVsZXRlOmN1c3RvbV9kb21haW5zIGNyZWF0ZTpjdXN0b21fZG9tYWlucyB1cGRhdGU6Y3VzdG9tX2RvbWFpbnMgcmVhZDplbWFpbF90ZW1wbGF0ZXMgY3JlYXRlOmVtYWlsX3RlbXBsYXRlcyB1cGRhdGU6ZW1haWxfdGVtcGxhdGVzIHJlYWQ6bWZhX3BvbGljaWVzIHVwZGF0ZTptZmFfcG9saWNpZXMgcmVhZDpyb2xlcyBjcmVhdGU6cm9sZXMgZGVsZXRlOnJvbGVzIHVwZGF0ZTpyb2xlcyByZWFkOnByb21wdHMgdXBkYXRlOnByb21wdHMgcmVhZDpicmFuZGluZyB1cGRhdGU6YnJhbmRpbmcgZGVsZXRlOmJyYW5kaW5nIHJlYWQ6bG9nX3N0cmVhbXMgY3JlYXRlOmxvZ19zdHJlYW1zIGRlbGV0ZTpsb2dfc3RyZWFtcyB1cGRhdGU6bG9nX3N0cmVhbXMgY3JlYXRlOnNpZ25pbmdfa2V5cyByZWFkOnNpZ25pbmdfa2V5cyB1cGRhdGU6c2lnbmluZ19rZXlzIHJlYWQ6bGltaXRzIHVwZGF0ZTpsaW1pdHMgY3JlYXRlOnJvbGVfbWVtYmVycyByZWFkOnJvbGVfbWVtYmVycyBkZWxldGU6cm9sZV9tZW1iZXJzIHJlYWQ6ZW50aXRsZW1lbnRzIHJlYWQ6YXR0YWNrX3Byb3RlY3Rpb24gdXBkYXRlOmF0dGFja19wcm90ZWN0aW9uIHJlYWQ6b3JnYW5pemF0aW9uc19zdW1tYXJ5IGNyZWF0ZTphdXRoZW50aWNhdGlvbl9tZXRob2RzIHJlYWQ6YXV0aGVudGljYXRpb25fbWV0aG9kcyB1cGRhdGU6YXV0aGVudGljYXRpb25fbWV0aG9kcyBkZWxldGU6YXV0aGVudGljYXRpb25fbWV0aG9kcyByZWFkOm9yZ2FuaXphdGlvbnMgdXBkYXRlOm9yZ2FuaXphdGlvbnMgY3JlYXRlOm9yZ2FuaXphdGlvbnMgZGVsZXRlOm9yZ2FuaXphdGlvbnMgY3JlYXRlOm9yZ2FuaXphdGlvbl9tZW1iZXJzIHJlYWQ6b3JnYW5pemF0aW9uX21lbWJlcnMgZGVsZXRlOm9yZ2FuaXphdGlvbl9tZW1iZXJzIGNyZWF0ZTpvcmdhbml6YXRpb25fY29ubmVjdGlvbnMgcmVhZDpvcmdhbml6YXRpb25fY29ubmVjdGlvbnMgdXBkYXRlOm9yZ2FuaXphdGlvbl9jb25uZWN0aW9ucyBkZWxldGU6b3JnYW5pemF0aW9uX2Nvbm5lY3Rpb25zIGNyZWF0ZTpvcmdhbml6YXRpb25fbWVtYmVyX3JvbGVzIHJlYWQ6b3JnYW5pemF0aW9uX21lbWJlcl9yb2xlcyBkZWxldGU6b3JnYW5pemF0aW9uX21lbWJlcl9yb2xlcyBjcmVhdGU6b3JnYW5pemF0aW9uX2ludml0YXRpb25zIHJlYWQ6b3JnYW5pemF0aW9uX2ludml0YXRpb25zIGRlbGV0ZTpvcmdhbml6YXRpb25faW52aXRhdGlvbnMgZGVsZXRlOnBob25lX3Byb3ZpZGVycyBjcmVhdGU6cGhvbmVfcHJvdmlkZXJzIHJlYWQ6cGhvbmVfcHJvdmlkZXJzIHVwZGF0ZTpwaG9uZV9wcm92aWRlcnMgZGVsZXRlOnBob25lX3RlbXBsYXRlcyBjcmVhdGU6cGhvbmVfdGVtcGxhdGVzIHJlYWQ6cGhvbmVfdGVtcGxhdGVzIHVwZGF0ZTpwaG9uZV90ZW1wbGF0ZXMgY3JlYXRlOmVuY3J5cHRpb25fa2V5cyByZWFkOmVuY3J5cHRpb25fa2V5cyB1cGRhdGU6ZW5jcnlwdGlvbl9rZXlzIGRlbGV0ZTplbmNyeXB0aW9uX2tleXMgcmVhZDpzZXNzaW9ucyBkZWxldGU6c2Vzc2lvbnMgcmVhZDpyZWZyZXNoX3Rva2VucyBkZWxldGU6cmVmcmVzaF90b2tlbnMgY3JlYXRlOnNlbGZfc2VydmljZV9wcm9maWxlcyByZWFkOnNlbGZfc2VydmljZV9wcm9maWxlcyB1cGRhdGU6c2VsZl9zZXJ2aWNlX3Byb2ZpbGVzIGRlbGV0ZTpzZWxmX3NlcnZpY2VfcHJvZmlsZXMgY3JlYXRlOnNzb19hY2Nlc3NfdGlja2V0cyByZWFkOmZvcm1zIHVwZGF0ZTpmb3JtcyBkZWxldGU6Zm9ybXMgY3JlYXRlOmZvcm1zIHJlYWQ6Zmxvd3MgdXBkYXRlOmZsb3dzIGRlbGV0ZTpmbG93cyBjcmVhdGU6Zmxvd3MgcmVhZDpmbG93c192YXVsdCB1cGRhdGU6Zmxvd3NfdmF1bHQgZGVsZXRlOmZsb3dzX3ZhdWx0IGNyZWF0ZTpmbG93c192YXVsdCByZWFkOmNsaWVudF9jcmVkZW50aWFscyBjcmVhdGU6Y2xpZW50X2NyZWRlbnRpYWxzIHVwZGF0ZTpjbGllbnRfY3JlZGVudGlhbHMgZGVsZXRlOmNsaWVudF9jcmVkZW50aWFscyIsImd0eSI6ImNsaWVudC1jcmVkZW50aWFscyIsImF6cCI6ImpSNVBjRnozWlpHMERiZ01zM1cwT1N3V0NlejZodzg5In0.lAHPwnTuB5DaYbXLA8yrHRtFmEg4YMKQtAlhyVnwegKezDXpgKsZDucwBJ6gk1XCY9rYkUzhkdfK33dF-0P9K-KQ4MsfYKnrOdPvSqe2Mfyt4ZcnX-d_rorq9YZOpuqnOO-N2tlFuipRqi2sB3qCJOjpOgJh2BOhR9S7epc65RncvsPT2ep4VD_2o5mY-3fzXWBOeT9j3v6LDoGWCWEGdjJ38z18aCeWxrPelTp04PM2DDoMquGI0XleWCXASFZXtMLxa_AAf6VrAb8uK2-yiTJ3B__ZqA-wgDqr-J5Ne1c9diD4538TWtJHygAyz4xoSqpGVdr3qm6KwfZPiG3S7w';
            let dataObj = JSON.stringify({ "user_metadata": {"email": user.email, "name": user.name, "picture": user.path}});

            axios.patch(`${process.env.ISSUER_DOMAIN}/api/v2/users/${user.auth0UserId}`, dataObj,{
                headers: {
                    "content-type": "application/json",
                    authorization: `Bearer ${token}`
                }
            })
            .then((response) => {
                console.log(response.data);
                return res.status(200).json({message: "User updated successfully"});
            })
            .catch((error: any)=> {
                console.log(error.data);
                // console.log('error attributes:', error.data?.attributes)
                return res.status(500).json({error: error.message});
            })

        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }

    static async deleteUser(req: ExtendedRequest, res: Response) {
        try {
            const UserRepository = AppDataSource.getRepository(User);
            const user = await UserRepository.findOne({where: {email: req.user?.email}});
            if (!user) {
                return res.status(404).json({message: "User not found"});
            }
            await UserRepository.delete(user.id);
            let token = await getToken();
            let options = {
                method: 'DELETE',
                url: `${process.env.ISSUER_DOMAIN}/api/v2/users/${user.auth0UserId}`,
                headers: {
                    'content-type': 'application/json',
                    'authorization': `Bearer ${token}`
                }
            };

            await axios.request(options).then((response) => {
                console.log(response.data);
            }).catch((error: any)=> {
                return res.status(500).json({error: error.message});
            })
            return res.status(200).json({message: "User deleted successfully"});
        } catch (error: any) {
            return res.status(500).json({error: error.message});
        }
    }
}