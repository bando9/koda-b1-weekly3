# ERD E-Wallet Bank JAGO

```mermaid

erDiagram
    USER {
        string id_user PK
        string name
        string email
        string phone
        string address
        string NIK
        date register_date
        string id_account FK
        date created_at
    }

    ACCOUNT {
        string id_account PK
        string id_transaction FK
        string id_user FK
        int current_amount
        string name
        string account_number
        date created_at
        date updated_at
    }

    USER ||--}o ACCOUNT: "have many"

    TRANSACTION {
        string id_transaction PK
        string id_account FK
        string id_user FK
        string description
        string status "enum('PENDING', 'ACTIVE', 'PAID')"
        string account_number
        int total_amount
        date created_at
        date transaction_date
    }

    ACCOUNT ||--}o TRANSACTION:"have many"
    USER ||--}o TRANSACTION: "have many"


```
