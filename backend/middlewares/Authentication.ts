import { Request, Response, NextFunction } from 'express';
import jwt, { JwtPayload } from 'jsonwebtoken';
import { JwksClient } from 'jwks-rsa';

export interface ExtendedRequest extends Request {
  user?: JwtPayload;
}

const client = new JwksClient({
  jwksUri: `${process.env.AUTH_ISSUER_DOMAIN}/.well-known/jwks.json`
});

function getKey(header: any, callback: (err: Error | null, signingKey?: string) => void) {
  if (!header.kid) {
    return callback(new Error('No kid found in JWT header'));
  }

  client.getSigningKey(header.kid, (err:any, key:any) => {
    if (err) {
      return callback(err);
    }
    const signingKey = key.publicKey || key.rsaPublicKey;
    if (!signingKey) {
      return callback(new Error('No signing key found'));
    }
    callback(null, signingKey);
  });
}


export const checkIsLoggedIn = (req: ExtendedRequest, res: Response, next: NextFunction) => {
    const accessToken = req.oidc?.idToken
    if (!accessToken) {
      return res.status(401).send({ exception: 'Unauthorized', message: 'No authorization token provided' });
    }
  
    jwt.verify(accessToken, getKey, {
    // audience: process.env.AUTH_ISSUER_AUDIENCE,
      issuer: `${process.env.AUTH_ISSUER_DOMAIN}/`,
      algorithms: [process.env.AUTH_TOKEN_ALG as any]
    }, (err, decoded) => {
      if (err) {
        return res.status(401).send({ exception: err, message: 'Unauthorized', err });
      }
      const decodedPayload = decoded as jwt.JwtPayload;
      
      const username = decodedPayload.name;
  
      if (!username) {
          return res.status(401).send({ exception: 'Unauthorized', message: "Unauthorized, You're not Logged In" });
        }
    
        // If org_uuid matches, attach decoded token to request and proceed
        req.user = decodedPayload;
        next();
    });
  };
