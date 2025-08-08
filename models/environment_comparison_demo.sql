
/*
    environment_comparison_demo.sql
    
    Demonstrates data differences between environments for data-diff testing.
    This model shows how the same logic can produce different results
    in development vs production environments.
*/

{% if target.name == "prod" %}

    /* Production version - orange color variant */
    select
        1 as id
        , 'orange' as color
        , 'prod' as environment
        , current_timestamp as created_at
    union all
    select
        2 as id
        , 'blue' as color
        , 'prod' as environment
        , current_timestamp as created_at

{% else %}

    /* Development version - black color variant for testing data-diff */
    select
        1 as id
        , 'black' as color
        , 'dev' as environment
        , current_timestamp as created_at
    union all
    select
        2 as id
        , 'blue' as color
        , 'dev' as environment
        , current_timestamp as created_at

{% endif %}
