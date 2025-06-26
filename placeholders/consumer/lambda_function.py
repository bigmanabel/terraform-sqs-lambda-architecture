"""
Placeholder Lambda function for initial deployment.

This function will be replaced by CodePipeline when you push code to your
configured GitHub repository. This is a minimal working function that
prevents deployment errors.

To deploy your actual Lambda code:
1. Set up your GitHub repository with producer/ and consumer/ directories
2. Activate the CodeStar connection in AWS Console
3. Push code to trigger the CodePipeline deployment
"""

import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    """
    Placeholder consumer function.
    
    This will be replaced by your actual consumer code via CodePipeline.
    """
    logger.info("Placeholder consumer function called")
    logger.info(f"Event: {json.dumps(event)}")
    
    # Process SQS records if present
    if 'Records' in event:
        for record in event['Records']:
            logger.info(f"Processing SQS message: {record.get('body', 'No body')}")
    
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Placeholder consumer function - deploy your code via CodePipeline',
            'processed_records': len(event.get('Records', []))
        })
    }
