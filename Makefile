
REGION ?= us-east-1

# heelerai-test-infrastructure
ACCOUNT_ID ?= 004492769043
APP_NAME = go-vulnerable-app



image:
	docker build --platform=linux/amd64 -t ${APP_NAME} .


run-image:
	docker run -p 8000:8000 -it ${APP_NAME}


publish-image:
	aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com
	docker tag ${APP_NAME}:latest ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/insecure:${APP_NAME}-latest
	docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/insecure:${APP_NAME}-latest
