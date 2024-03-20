### 1) Matches
Data loader
```
import io
import pandas as pd
import requests
from io import BytesIO

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

@data_loader
def load_data(*args, **kwargs):

    url = 'https://github.com/RoshchinM/de_zoomcamp_2024_UCL_2016-2022/raw/main/assets/UEFA%20Champions%20League%202016-2022%20Data.xlsx'
    
    response = requests.get(url)
    file_content = BytesIO(response.content)

    df = pd.read_excel(file_content, sheet_name='matches')

    return df
```

Data transformer (no specific transformation till dbt cloud)
```
if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

@transformer
def transform(data, *args, **kwargs):
    return data

@test
def test_output(output, *args) -> None:
    assert output is not None, 'The output is undefined'

```

Data loader to GCP
```
from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from pandas import DataFrame
from os import path

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    bucket_name = 'ucl_main_bucket'
    object_key = 'matches.parquet'

    GoogleCloudStorage.with_config(ConfigFileLoader(config_path, config_profile)).export(
        df,
        bucket_name,
        object_key,
    )
```