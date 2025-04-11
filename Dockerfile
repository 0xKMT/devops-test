FROM python:3.12-slim
 
WORKDIR /app
 
COPY pyproject.toml poetry.lock poetry.toml ./

RUN pip install --no-cache-dir poetry

RUN poetry install --no-root --no-interaction
 
COPY . .

EXPOSE 3000
 
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh
 
CMD ["/app/entrypoint.sh"]