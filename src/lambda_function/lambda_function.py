import logging
import os

import boto3

DEST_PHONE_NUMBER = "+xxxxxxxxxxxx"

logger = logging.getLogger()
logger.setLevel(logging.INFO)
connect = boto3.client("connect")

def lambda_handler(event, context) -> None:
    contact = connect.start_outbound_voice_contact(
        DestinationPhoneNumber=DEST_PHONE_NUMBER,
        ContactFlowId=os.getenv('CONNECT_CONTACT_FLOW_ID'),
        InstanceId=os.getenv('CONNECT_INSTANCE_ID'),
        SourcePhoneNumber=os.getenv('SOURCE_PHONE_NUMBER'),
        Attributes={"message": "This is alert notification system."},
    )

