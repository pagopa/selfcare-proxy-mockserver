# Mock-server 

Mock-server è un componente in formato container utilizzato per realizzare velocemente mock per i servizi esterni
da utilizzare in ambienti di test o per mimare il servizio reale prima che questo sia disponibile.

Documentazione su https://www.mock-server.com/

## Mock-server configuration

La configurazione del mock server è fatta tramite file json nella cartella _services_.

## Mock per ms-party-registry-proxy

### InfoCamere

#### Servizio interoperabilità InfoCamere
Path: `/selfcaremock/ic/ce/wspa/wspa/rest/authentication`

| Body input                  | Status Code | Body output           |
|-----------------------------|-------------|-----------------------|
| Qualsiasi Token JWT firmato | 200         | Token JWT             |
| Qualsiasi altro valore      | 400         | Internal server error |

Esempio d'invocazione

```bash
curl --location --request POST 'http://localhost:1080/selfcaremock/ic/ce/wspa/wspa/rest/authentication?client_id=test' \
--header 'Content-Type: text/plain' \
--data-raw 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c'
```

#### Legale rappresentante elenco
Path: `/selfcaremock/ic/ce/wspa/wspa/rest/listaLegaleRappresentante`

| CodiceFiscale               | Status Code | Body                                                                                                                                            |
|-----------------------------|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| DLLDGI53T30I324E            | 200         | 3 imprese: <ul><li>01501320442-DIEGO DELLA VALLE & C. S.R.L.</li><li>02492030446-DEVA FINANCE S.R.L.</li><li>01113570442-TOD'S S.R.L.</li></ul> |
| CCRMCT06A03A433H            | 200         | Ditta individuale: CCRMCT06A03A433H-Marco Tullio Cicerone                                                                                       |
| SNCLNN00A01H501S            | 200         | 1 impresa: SNCLNN00A01H501S-LuAnSe SpA                                                                                                          |
| CTNMCP80A01H501M            | 200         | 3 imprese: <ul><li>70472431207-VeryBadCaligola Snc</li><li>27937810870-DisTerminatio Sas</li><li>12825810299-Effimera Stoica S.r.l.</li></ul>   |
| CIACIA80A01H501X            | 500         | Internal server error                                                                                                                           |
| Qualsiasi CF o P.IVA valido | 200         | Errore Not found                                                                                                                                |

Esempio d'invocazione

```bash
curl --location --request GET 'http://localhost:1080/selfcaremock/ic/ce/wspa/wspa/rest/listaLegaleRappresentante/DLLDGI53T30I324E?client_id=test' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c'
```

### National-registries

#### ADE

##### Verifica Legale rappresentante ADE
Path: `/selfcaremock/national-registries-private/agenzia-entrate/legal`

| Codice Fiscale legale | Codice Fiscale impresa      | Status Code   | Risposta       |
|-----------------------|-----------------------------|---------------|----------------|
| DLLDGI53T30I324E      | 11023406579                 | 200           | Verifica true  |
| DLLDGI53T30I324E      | 12433658872                 | 200           | Verifica false |

Esempio d'invocazione

```bash
curl --location --request POST 'http://localhost:1080/selfcaremock/national-registries-private/agenzia-entrate/legal' \
--header 'Content-Type: application/json' \
--data-raw '{
    "filter": {
        "taxId": "DLLDGI53T30I324E",
        "vatNumber": "11023406579"
    }
}'
```

#### InfoCamere

##### Sede Legale
Path: `/selfcaremock/national-registries-private/registro-imprese/address`

| Codice Fiscale/P.IVA      | Status Code | Body             |
|---------------------------|-------------|------------------|
| 01501320442               | 200         | Sede trovata     |
| 01113570442               | 200         | Sede trovata     |
| Qualsiasi CF/P.IVA valida | 200         | Sede non trovata |

Esempio d'invocazione

```bash
curl --location --request POST 'http://localhost:1080/selfcaremock/national-registries-private/registro-imprese/address' \
--header 'Content-Type: application/json' \
--data-raw '{
    "filter": {
        "taxId": "01501320442"
    }
}'
```
